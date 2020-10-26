//
//  CourseDetailsVC.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 10/1/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import UIKit

class CourseDetailsVC: UIViewController {
  var courseContentUrl: String?
  @IBOutlet var courseLogoImageView: UIImageView!
  @IBOutlet var courseTitle: UILabel!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var courseBody: UITextView!
  @IBOutlet var courseDescription: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    loadCourseContent()
  }

  // MARK: - Load Course Content
  private func loadCourseContent() {
    var description = ""
    var itemName = ""
    var courseContent: NSMutableAttributedString?
    var cardArtwork = UIImage()
    let fetchCourseContentDispatchGroup = DispatchGroup()
    guard let courseContentUrl = courseContentUrl else { return }
    activityIndicator.startAnimating()
    fetchCourseContentDispatchGroup.enter()

    CourseAPIService.shared.fetchCourseContent(for: courseContentUrl) { courseContentResults in
      switch courseContentResults {
      case .success(let courseContentResults):
        let item = courseContentResults.data
        DispatchQueue.main.async {
          description = item.attributes.descriptionPlainText
          itemName = item.attributes.name
          let htmlContent = item.attributes.body ?? ""
          let htmlData = Data(htmlContent.utf8)
          let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]

          if let body = try? NSMutableAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            body.addAttributes(attributes, range: _NSRange(location: 0, length: body.length))
            courseContent = body
          }
          fetchCourseContentDispatchGroup.leave()
        }
        guard let cardArtWorkUrl = URL(string: item.attributes.cardArtworkUrl) else { return }
        fetchCourseContentDispatchGroup.enter()
        CourseAPIService.shared.fetchCardArtwork(for: cardArtWorkUrl) { results in
          switch results {
          case .success(let artworkImage):
            cardArtwork = artworkImage
            fetchCourseContentDispatchGroup.leave()
          case .failure(let error):
            print("Failed to download content artwork: \(error)")
          }
        }
      case .failure(let error):
        print("Could not retrieve course content:\(error)")
      }

      fetchCourseContentDispatchGroup.notify(queue: .main) {
        self.activityIndicator.stopAnimating()
        self.courseDescription.text = description
        self.courseBody.attributedText = courseContent
        self.courseLogoImageView.contentMode = .scaleAspectFill
        self.courseLogoImageView.layer.cornerRadius = 5
        self.courseLogoImageView.layer.masksToBounds = true
        self.courseLogoImageView.image = cardArtwork
        self.courseTitle.text = itemName
      }
    }
  }
}
