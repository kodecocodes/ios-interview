//
//  TagView.swift
//  RW Take Home
//
//  Created by Zoha on 7/16/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit


class TagView: UIView {
  
  let titleLabel = UILabel()
  let iconImageView = UIImageView()
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var iconImage: UIImage? {
    didSet {
      iconImageView.image = iconImage
    }
  }
  
  private let iconSize: CGFloat = 16
  private let iconHorizontalMargin: CGFloat = 5
  private let titleTrailingMargin: CGFloat = 8
  private let titleVerticalMargin: CGFloat = 3
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    iconImageView.tintColor = .white
    
    titleLabel.setupLabel(withTextStyle: .caption1, textColor: .white)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    self.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(titleLabel)
    addSubview(iconImageView)
    
    layer.cornerRadius = 6
    clipsToBounds = true
    
    NSLayoutConstraint.activate([
      iconImageView.heightAnchor.constraint(equalToConstant: iconSize),
      iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
      iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: iconHorizontalMargin),
      
      iconImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -iconHorizontalMargin),
      
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: titleVerticalMargin),
      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -titleVerticalMargin),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -titleTrailingMargin)
    ])
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    invalidateIntrinsicContentSize()
  }
  
  override var intrinsicContentSize: CGSize {
    let width = titleLabel.intrinsicContentSize.width + titleTrailingMargin + iconSize + (iconHorizontalMargin * 2)
    let height = titleLabel.intrinsicContentSize.height + (titleVerticalMargin * 2)
    
    return CGSize(width: width, height: height)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }
}
