import Foundation
import UIKit

protocol GithubRestServiceProtocol {
    var fetchedDomains: [TechnologyDomain] { get set }

    func getCourses(
        _ courses: CourseType...,
        completion: @escaping ([CourseInfo]) -> Void
    )
}

class GithubRestService: GithubRestServiceProtocol {
    // MARK: - Private Properties

    private let host = "https://raw.githubusercontent.com"

    private let wenderlichPracticeExamplesPath = "/raywenderlich/ios-interview/master/Practical%20Example/"

    private let articlesPathSuffix = "articles.json"
    
    private let videosPathSuffix = "videos.json"

    // MARK: - Public Properties

    var fetchedDomains = [TechnologyDomain]()

    // MARK: - Public Methods

    func getCourses(
        _ courses: CourseType...,
        completion: @escaping ([CourseInfo]) -> Void
    ) {
        var fetchedCourses = [CourseInfo]()
        let dispatchGroup = DispatchGroup()
        
        courses.forEach {
            dispatchGroup.enter()
            switch $0 {
            case .article:
                self.fetchCourses(ofType: .article) { articles in
                    fetchedCourses.append(contentsOf: articles)
                    dispatchGroup.leave()
                }
            case .collection:
                self.fetchCourses(ofType: .collection) { videos in
                    fetchedCourses.append(contentsOf: videos)
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(fetchedCourses)
        }
    }
    
    // MARK: - Private Methods

    private func fetchCourses(
        ofType type: CourseType,
        completion: @escaping ([CourseInfo]) -> Void
    ) {
        guard let url = createURL(for: type) else {
            completion([])
            return
        }

        URLSession.get(url: url) { data, error in
            if let error = error {
                print(error)
                completion([])
            } else if let data = data {
                let responseBody = try? JSONDecoder().decode(
                    GithubResponseBody.self,
                    from: data)

                self.fetchedDomains = responseBody?.included?.compactMap { $0.type == "domains" ? TechnologyDomain($0) : nil } ?? []
                let coursesInfo = responseBody?.data?.compactMap { CourseInfo($0, domains: self.fetchedDomains) } ?? []
                
                completion(coursesInfo)
            } else {
                completion([])
            }
        }
    }

    private func createURL(
        for courseType: CourseType
    ) -> URL? {
        var url = URL(string: host + wenderlichPracticeExamplesPath)
        switch courseType {
        case .article:
            url?.appendPathComponent(articlesPathSuffix)
        case .collection:
            url?.appendPathComponent(videosPathSuffix)
        }

        return url
    }
}
