//
//  CourseListViewController.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 10/16/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import UIKit

class CourseListVC: UIViewController {
  private var courseContentUrl: String?
  private var courses = [Item]()
  private var dataSource: UITableViewDiffableDataSource<Section, Item>?
  private  let utilityQueue = DispatchQueue(label: "utilityQueue", qos: .utility)
  private let courseManager = CourseAPIService()
  private let timeFormatter: DateComponentsFormatter = {
    let timeFormatter = DateComponentsFormatter()
    timeFormatter.allowedUnits = [.hour, .minute]
    timeFormatter.unitsStyle = .short
    return timeFormatter
  }()
  @IBOutlet var courseList: UITableView!
  @IBAction func filterCourses(_ sender: UISegmentedControl) {
    var filteredContent = [Item]()

    switch sender.selectedSegmentIndex {
    case 0:
      filteredContent = courses
    case 1:
      filteredContent = courses.filter { $0.attributes.contentType == ContentType.article }
    case 2:
      filteredContent = courses.filter { $0.attributes.contentType == ContentType.collection }
    default:
      filteredContent = courses
    }

    utilityQueue.async {
      self.createSnapshot(from: filteredContent.sorted { $0.attributes.releasedAt > $1.attributes.releasedAt })
    }
  }

    override func viewDidLoad() {
      super.viewDidLoad()
      courseList.delegate = self
      courseList.dataSource = dataSource
      configureDataSource()
      fetchArticles()
      fetchVideos()
    }

  private func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: courseList) { tableView, indexPath, item -> UITableViewCell in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseListCell.reuseId, for: indexPath) as? CourseListCell else { return UITableViewCell() }
      let duration = self.timeFormatter.string(from: TimeInterval(Double(item.attributes.duration))) ?? ""

      cell.courseName.text = item.attributes.name
      cell.courseDescription.text = item.attributes.descriptionPlainText
      cell.duration.text = "(\(duration))"
      cell.courseType.text = item.attributes.contentType == ContentType.article ? "Article Course" : "Video Course"
      cell.releaseDate.text = item.attributes.releasedAt.formatDateString()//.description.formatDate()
      cell.links = item.links

      if let cardArtworkUrl = URL(string: item.attributes.cardArtworkUrl) {
        CourseAPIService.shared.fetchCardArtwork(for: cardArtworkUrl) { result in
          switch result {
          case .success(let artwork):
            DispatchQueue.main.async {
              cell.artwork.contentMode = .scaleAspectFill
              cell.artwork.layer.cornerRadius = 5
              cell.artwork.layer.masksToBounds = true
              cell.artwork.image = artwork
            }
          case .failure(let error):
            switch error {
            case .imageDataError:
              print(error.localizedDescription)
            default:
              print("Artwork Error: \(error.localizedDescription)")
            }
          }
        }
      }
      return cell
    }
  }

  private func createSnapshot(from courses: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(courses, toSection: .main)
    dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
  }

  private func fetchArticles() {
    let articleUrl = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/articles.json"

    CourseAPIService.shared.fetchContent(for: articleUrl) { results in
      switch results {
      case .success(let results):
        self.courses.append(contentsOf: results.data)
      case .failure(let error):
        print("Failed: \(error.localizedDescription)")
      }
    }
  }

  private func fetchVideos() {
    let videoUrl = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/videos.json"

      CourseAPIService.shared.fetchContent(for: videoUrl) { results in
        switch results {
        case .success(let results):
          self.courses.append(contentsOf: results.data)
          let coursesSortedByDateDescending = self.courses.sorted(by: { $0.attributes.releasedAt > $1.attributes.releasedAt })
          self.createSnapshot(from: coursesSortedByDateDescending)
        case .failure(let error):
          print("Failed: \(error.localizedDescription)")
        }
      }
  }
}

extension CourseListVC: UITableViewDelegate {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let courseListCell = sender as? CourseListCell else { return }

    if let courseContentUrl = courseListCell.links?.current {
      if segue.identifier == StoryboardSegue.CourseDetailsSegue {
        if let courseDetailsVC = segue.destination as? CourseDetailsVC {
          courseDetailsVC.courseContentUrl = courseContentUrl
        }
      }
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if courseList.contentOffset.y > 0 {
      navigationController?.navigationBar.prefersLargeTitles = false
    } else {
      navigationController?.navigationBar.prefersLargeTitles = true
    }
  }
}
