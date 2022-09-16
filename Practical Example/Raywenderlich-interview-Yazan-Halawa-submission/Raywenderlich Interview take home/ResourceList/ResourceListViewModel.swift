//
//  ResourceListViewModel.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import Foundation
import Combine

class ResourceListViewModel: ObservableObject {
    @Published private(set) var resources: [Resource] = []
    private(set) var totalResources: [Resource] = []
    private var shownResourceTypes: [ContentType] = [.article, .collection] {
        didSet {
            resources = totalResources.filter { shownResourceTypes.contains($0.attributes.content_type)
            }.sortedByReleaseDate()
        }
    }
    
    private let networkManager: MakesNetworkRequests
    
    init(withNetworkManager networkManager: MakesNetworkRequests = NetworkManager.shared) {
        // We dependency inject the network manager so we can mock it for unit testing purposes when needed
        self.networkManager = networkManager
    }
    
    func fetchResources() async {
        var resources: [Resource] = []
        
        // We want to have all network requests fire in parallel and await on all of them
        async let articlesFetchResult: Result<ResourceData, NetworkError> = networkManager.request(endpoint: RayWenderlich.articles)
        async let videosFetchResult: Result<ResourceData, NetworkError> = networkManager.request(endpoint: RayWenderlich.videos)
        let results = await [articlesFetchResult, videosFetchResult]
        
        // For now we just add any values that arrived
        // TODO Error handling here. Should we show an error if any call fails? or both?
        for result in results {
            switch result {
            case .success(let resourceData):
                resources.append(contentsOf: resourceData.data)
            case .failure:
                return
            }
        }
        self.totalResources.append(contentsOf: resources.sortedByReleaseDate())
        self.showAllTypes()
    }
    
    @objc func showOnlyArticles() {
        shownResourceTypes = [.article]
    }
    
    @objc func showOnlyVideos() {
        shownResourceTypes = [.collection]
    }
    
    @objc func showAllTypes() {
        shownResourceTypes = [.article, .collection]
    }
}

fileprivate extension Array where Element == Resource {
    func sortedByReleaseDate() -> [Resource] {
        return self.sorted(by: { $0.attributes.released_at.compare($1.attributes.released_at) == .orderedDescending })
    }
}
