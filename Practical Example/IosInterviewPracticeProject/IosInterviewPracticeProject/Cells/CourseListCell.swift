//
//  CourseListCell.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/25/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import UIKit

class CourseListCell: UITableViewCell {
  static let reuseId = "CourseListCell"
  @IBOutlet var artwork: UIImageView!
  @IBOutlet var courseName: UILabel!
  @IBOutlet var courseDescription: UILabel!
  @IBOutlet var releaseDate: UILabel!
  @IBOutlet var courseType: UILabel!
  @IBOutlet var duration: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    }
}
