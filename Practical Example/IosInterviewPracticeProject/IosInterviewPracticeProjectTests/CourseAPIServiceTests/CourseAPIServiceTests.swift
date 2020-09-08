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
    let expect = expectation(description: "Articles download task completed")
    let articleUrl = "https://api.jsonbin.io/b/5ed679357741ef56a566a67f"
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
    let expect = expectation(description: "Videos download task completed")
    let videoUrl = "https://api.jsonbin.io/b/5ed67c667741ef56a566a831"
    var items = [Item]()

    courseAPIService.fetchVideos(for: videoUrl) { results in
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
    let expect = expectation(description: "Artwork download task completed")
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
}
