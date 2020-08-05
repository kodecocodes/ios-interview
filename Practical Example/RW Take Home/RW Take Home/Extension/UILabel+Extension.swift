//
//  Utility.swift
//  RW Take Home
//
//  Created by Zoha on 7/16/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

extension UILabel {
  func setupLabel(
    withTextStyle style: UIFont.TextStyle,
    textColor: UIColor = .label,
    numberOfLines: Int = 1
  ) {
    font = .preferredFont(forTextStyle: style)
    adjustsFontForContentSizeCategory = true
    self.textColor = textColor
    self.numberOfLines = numberOfLines
  }
}
