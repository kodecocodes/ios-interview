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

    switch Filter(rawValue: sender.selectedSegmentIndex) {
    case .all:
      filteredContent = courses
    case .article:
      filteredContent = courses.filter { $0.attributes.contentType == ContentType.article }
    case .collection:
      filteredContent = courses.filter { $0.attributes.contentType == ContentType.collection }
    default:
      filteredContent = courses
    }

    DispatchQueue.main.async {
      self.createSnapshot(from: filteredContent.sorted { $0.attributes.releasedAt > $1.attributes.releasedAt })
    }
  }

    override func viewDidLoad() {
      super.viewDidLoad()
      courseList.delegate = self
      courseList.dataSource = dataSource
      configureDataSource()
      fetchContent()
    }

  private func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: courseList) { tableView, indexPath, item -> UITableViewCell in
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseListCell.reuseId, for: indexPath) as? CourseListCell else { return UITableViewCell() }
      let duration = self.timeFormatter.string(from: TimeInterval(Double(item.attributes.duration))) ?? ""

      cell.courseName.text = item.attributes.name
      cell.courseDescription.text = item.attributes.descriptionPlainText
      cell.duration.text = "(\(duration))"
      cell.courseType.text = item.attributes.contentType == ContentType.article ? "Article Course" : "Video Course"
      cell.releaseDate.text = item.attributes.releasedAt.formatDateString()
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

  private func fetchContent() {
    let fetchContentDispatchGroup = DispatchGroup()

    fetchContentDispatchGroup.enter()
    CourseAPIService.shared.fetchContent(for: articleUrl) { results in
      switch results {
      case .success(let results):
        self.courses.append(contentsOf: results.data)
        fetchContentDispatchGroup.leave()
      case .failure(let error):
        print("Failed: \(error.localizedDescription)")
      }
    }

    fetchContentDispatchGroup.enter()
    CourseAPIService.shared.fetchContent(for: videoUrl) { results in
      switch results {
      case .success(let results):
        self.courses.append(contentsOf: results.data)
        fetchContentDispatchGroup.leave()
      case .failure(let error):
        print("Failed: \(error.localizedDescription)")
      }
    }

    fetchContentDispatchGroup.notify(queue: .main) {
      let coursesSortedByDateDescending = self.courses.sorted { $0.attributes.releasedAt > $1.attributes.releasedAt }
      self.createSnapshot(from: coursesSortedByDateDescending)
    }
  }
}

extension CourseListVC: UITableViewDelegate {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let courseListCell = sender as? CourseListCell else { return }

    if let courseContentUrl = courseListCell.links?.current, segue.identifier == StoryboardSegue.CourseDetailsSegue, let courseDetailsVC = segue.destination as? CourseDetailsVC {
      courseDetailsVC.courseContentUrl = courseContentUrl
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    navigationController?.navigationBar.prefersLargeTitles = courseList.contentOffset.y <= 0
  }
}
