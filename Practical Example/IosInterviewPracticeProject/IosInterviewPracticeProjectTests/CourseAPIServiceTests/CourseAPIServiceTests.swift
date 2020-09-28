//
//  NetworkManagerTests.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/20/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import XCTest
@testable import raywenderlich

class CourseAPIServiceTests: XCTestCase {
  var artworkUrl: URL?
  var courseAPIService = CourseAPIService()

  override func setUpWithError() throws {
    artworkUrl = URL(string: "https://files.betamax.raywenderlich.com/attachments/collections/244/e2d20345-06fb-42f4-8366-c7ffe80b5f77.png")
  }

    override func tearDownWithError() throws {
      artworkUrl = nil
    }

  func testFetchArticles() {
    let expect = expectation(description: "Fetch Articles")
    let articleUrl = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/articles.json"
    var items = [Item]()

    courseAPIService.fetchContent(for: articleUrl) { results in
      switch results {
      case .success(let results):
        items = results.data
        expect.fulfill()
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    waitForExpectations(timeout: 3, handler: nil)
    XCTAssertGreaterThan(items.count, 0, "Failed to fetch articles")
  }

  func testFetchVideos() {
    let expect = expectation(description: "Fetch Videos")
    let videoUrl = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/videos.json"
    var items = [Item]()

    courseAPIService.fetchContent(for: videoUrl) { results in
      switch results {
      case .success(let results):
        items = results.data
        expect.fulfill()
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    waitForExpectations(timeout: 3, handler: nil)
    XCTAssertGreaterThan(items.count, 0, "Failed to fetch videos")
  }

  func testFetchCardArtwork() {
    let expect = expectation(description: "Fetch Artwork")
    var artwork: UIImage?

    guard let artworkUrl = self.artworkUrl else {
      XCTFail("Invalid artwork URL")
      return
    }

    //create a new artwork image
    courseAPIService.fetchCardArtwork(for: artworkUrl) { result in
      switch result {
      case .success(let artworkImage):
        artwork = artworkImage
        expect.fulfill()
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }

    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(artwork, "Failed to fetch artwork")
  }

  func testFetchCourseContent() {
    var items = [Item]()
    let contentUrl = "http://api.raywenderlich.com/api/contents/10628623-mac-catalyst-with-andy-pereira-podcast-s10-e7"
    let expect = expectation(description: "Fetch content")

    courseAPIService.fetchContent(for: contentUrl) { results in
      switch results {
      case .success(let results):
        items = results.data
        print("Items: \(items)")
        expect.fulfill()
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    waitForExpectations(timeout: 3, handler: nil)
    XCTAssertGreaterThan(items.count, 0, "Failed to fetch content")
  }
}
