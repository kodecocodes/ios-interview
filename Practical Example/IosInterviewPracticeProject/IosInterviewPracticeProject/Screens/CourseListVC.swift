//
//  CourseListVC.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/16/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import UIKit

class CourseListVC: UITableViewController {
  private var dataSource: UITableViewDiffableDataSource<Section, Results>?
  private let courseManager = CourseAPIService()

  override func viewDidLoad() {
    super.viewDidLoad()
    //fetchVideos()
    //fetchArticles()
  }

  private func fetchArticles() {
    courseManager.fetchArticles { results in
      switch results {
      case .success(let results):
        let items = results.data
        for item in items {
          print("Name: \(item.attributes.name)")
          print("Description: \(item.attributes.description)")
          print("Content Type: \(item.attributes.contentType)")
          print("Release Date: \(item.attributes.releasedAt.formatDate(dateFormat: "MMM d, yyyy"))")
          print("")
        }
      case .failure(let error):
        print("Failed: \(error.localizedDescription)")
      }
    }
  }

  private func fetchVideos() {
    courseManager.fetchVideos { results in
      switch results {
      case .success(let results):
        let items = results.data
        for item in items {
          print("Name: \(item.attributes.name)")
          print("Description: \(item.attributes.description)")
          print("Content Type: \(item.attributes.contentType)")
          print("Release Date: \(item.attributes.releasedAt.formatDate(dateFormat: "MMM d, yyyy"))")
          print("")
        }
      case .failure(let error):
        print("Failed: \(error.localizedDescription)")
      }
    }
  }
}

extension CourseListVC {
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
}

extension String {
  func formatDate(dateFormat: String) -> String {
    let iso8601DateFormatter = ISO8601DateFormatter()
    iso8601DateFormatter.formatOptions = .withFullDate

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = dateFormat

    guard let isoDate = iso8601DateFormatter.date(from: self) else { return self }

    let formattedDate = dateFormatter.string(from: isoDate)

    return formattedDate
  }
}
