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

  override func viewDidLoad() {
    super.viewDidLoad()
    loadCourseContent()
  }

  // MARK: - Load Course Content
  private func loadCourseContent() {
    var itemName = ""
    guard let courseContentUrl = courseContentUrl else { return }
    activityIndicator.startAnimating()

    CourseAPIService.shared.fetchCourseContent(for: courseContentUrl) { courseContentResults in
      switch courseContentResults {
      case .success(let courseContentResults):
        let item = courseContentResults.data
        DispatchQueue.main.async {
          itemName = item.attributes.name
          if let htmlContent = item.attributes.body {
            let htmlData = Data(htmlContent.utf8)
            self.courseBody.attributedText = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
          } else {
            self.courseBody.text = item.attributes.descriptionPlainText
          }
        }
        guard let cardArtWorkUrl = URL(string: item.attributes.cardArtworkUrl) else { return }

        CourseAPIService.shared.fetchCardArtwork(for: cardArtWorkUrl) { results in
          switch results {
          case .success(let cardArtWork):
            DispatchQueue.main.async {
              self.activityIndicator.stopAnimating()
              self.courseLogoImageView.contentMode = .scaleAspectFill
              self.courseLogoImageView.layer.cornerRadius = 5
              self.courseLogoImageView.layer.masksToBounds = true
              self.courseLogoImageView.image = cardArtWork
              self.courseTitle.text = itemName
            }
          case .failure(let error):
            print("Failed to download content artwork: \(error)")
          }
        }
      case .failure(let error):
        print("Could not retrieve course content:\(error)")
      }
    }
  }
}
