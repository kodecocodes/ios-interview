//
//  Raywenderlich_Interview_take_homeTests.swift
//  Raywenderlich Interview take homeTests
//
//  Created by Yazan Halawa on 9/13/22.
//

import XCTest
@testable import Raywenderlich_Interview_take_home

final class Raywenderlich_Interview_take_homeTests: XCTestCase {
    class MockNetworkManager: MakesNetworkRequests {
        let resource1 = Resource(id: "1", type: "type1", attributes: Attributes(uri: "randomURI", name: "randomName", description: "randomDesc", released_at: "2020-03-31T13:00:00.000Z", free: true, difficulty: .beginner, content_type: .article, duration: 2, popularity: 2, technology_triple_string: "", contributor_string: "", ordinal: nil, professional: false, description_plain_text: "", video_identifier: "", parent_name: "", card_artwork_url: ""))
        let resource2 = Resource(id: "2", type: "type1", attributes: Attributes(uri: "randomURI", name: "randomName", description: "randomDesc", released_at: "2020-03-29T13:00:00.000Z", free: true, difficulty: .beginner, content_type: .collection, duration: 2, popularity: 2, technology_triple_string: "", contributor_string: "", ordinal: nil, professional: false, description_plain_text: "", video_identifier: "", parent_name: "", card_artwork_url: ""))
        let resource3 = Resource(id: "3", type: "type1", attributes: Attributes(uri: "randomURI", name: "randomName", description: "randomDesc", released_at: "2020-03-30T13:00:00.000Z", free: true, difficulty: .beginner, content_type: .collection, duration: 2, popularity: 2, technology_triple_string: "", contributor_string: "", ordinal: nil, professional: false, description_plain_text: "", video_identifier: "", parent_name: "", card_artwork_url: ""))
        
        func request<T: Decodable>(endpoint: Endpoint) async -> (Result<T, NetworkError>) {
            
            let data = ResourceData(data: [resource1, resource2, resource3])
            return .success(data as! T)
        }
    }

    func testFetchingResourcesReturnsMockValues() async throws {
        let viewModel = ResourceListViewModel(withNetworkManager: MockNetworkManager())
        await viewModel.fetchResources()
        // Since in the view model we fetch resources which makes a call to request twice we will duplicate the three resources resulting in 6
        assert(viewModel.resources.count == 6)
    }
    
    func testFilteringToOnlyArticlesReturnsOnlyArticles() async throws {
        let viewModel = ResourceListViewModel(withNetworkManager: MockNetworkManager())
        await viewModel.fetchResources()
        viewModel.showOnlyArticles()
        // There are 2 "article" type resources in the mocked data
        assert(viewModel.resources.count == 2)
    }
    
    func testFilteringToOnlyVideosReturnsOnlyVideos() async throws {
        let viewModel = ResourceListViewModel(withNetworkManager: MockNetworkManager())
        await viewModel.fetchResources()
        viewModel.showOnlyVideos()
        // There are 4 "collection" type resources in the mocked data
        assert(viewModel.resources.count == 4)
    }
    
    func testSortingResourcesByReleaseDate() async throws {
        let viewModel = ResourceListViewModel(withNetworkManager: MockNetworkManager())
        await viewModel.fetchResources()
        // Since we have duplicates this will be a good test if items released on the same data
        // Since in our mock resources we have resource 1 released latest, then resource 3, then 2. We should have that order with each resource repeated back to back
        assert(viewModel.resources[0].id == "1")
        assert(viewModel.resources[1].id == "1")
        assert(viewModel.resources[2].id == "3")
        assert(viewModel.resources[3].id == "3")
        assert(viewModel.resources[4].id == "2")
        assert(viewModel.resources[5].id == "2")
    }
}
