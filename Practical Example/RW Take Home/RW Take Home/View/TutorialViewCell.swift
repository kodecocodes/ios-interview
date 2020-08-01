//
//  TutorialViewCell.swift
//  RW Take Home
//
//  Created by Zoha on 7/16/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class TutorialViewCell: UICollectionViewCell {
  
  static let reuseIdentifier: String = String(describing: TutorialViewCell.self)
  
  let releaseLabel = UILabel()
  let titleLabel = UILabel()
  let detailLabel = UILabel()
  let artWorkImage = UIImageView()
  
  let typeTagView = TagView()
  let durationTagView = TagView()
  
  let titleStack = UIStackView()
  let artStack = UIStackView()
  let tagStack = UIStackView()
  let mainStack = UIStackView()
  
  let dummyView = UILabel()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    setupShadow()
    setupTitleStack()
    setupArtStack()
    setupTagStack()
    setupTagStack()
    setupMainStack()
    
    contentView.addSubview(mainStack)
    
    NSLayoutConstraint.activate([
      mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("storyboard is not supported")
  }
  
  func setupShadow() {
    backgroundView = UIView()
    backgroundView?.backgroundColor = .tertiarySystemBackground
    backgroundView?.layer.cornerRadius = 10
    backgroundView?.layer.shadowColor = UIColor.black.cgColor
    backgroundView?.layer.shadowRadius = 5
    backgroundView?.layer.shadowOpacity = 0.2
    backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 5)
  }
  
  func setupTitleStack() {
    releaseLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
    releaseLabel.setupLabel(withTextStyle: .subheadline, textColor: .secondaryLabel)
    
    titleLabel.setupLabel(withTextStyle: .title3, numberOfLines: 2)
    
    titleStack.addArrangedSubview(releaseLabel)
    titleStack.addArrangedSubview(titleLabel)
    
    titleStack.axis = .vertical
    titleStack.alignment = .leading
    titleStack.distribution = .fill
    titleStack.setCustomSpacing(5, after: releaseLabel)
  }
  
  func setupArtStack() {
    artWorkImage.layer.cornerRadius = 6
    artWorkImage.clipsToBounds = true
    
    let heightConstraint =  artWorkImage.heightAnchor.constraint(equalToConstant: 75)
    heightConstraint.priority = .required - 1
    NSLayoutConstraint.activate([
      heightConstraint,
      artWorkImage.widthAnchor.constraint(equalToConstant: 80)
    ])
    
    artStack.addArrangedSubview(titleStack)
    artStack.addArrangedSubview(artWorkImage)
    
    artStack.axis = .horizontal
    artStack.alignment = .leading
    artStack.spacing = 10
  }
  
  func setupTagStack() {
    
    typeTagView.setContentHuggingPriority(.defaultHigh + 2, for: .horizontal)
    durationTagView.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
    
    tagStack.addArrangedSubview(typeTagView)
    tagStack.addArrangedSubview(durationTagView)
    // DummyLabel is Added just to align the two Tag Views to the leading
    tagStack.addArrangedSubview(dummyView)
    
    tagStack.alignment = .fill
    tagStack.distribution = .fill
    tagStack.setCustomSpacing(10, after: typeTagView)
  }
  
  func setupMainStack() {
    detailLabel.setupLabel(withTextStyle: .body,textColor: .secondaryLabel, numberOfLines: 2)
    
    mainStack.addArrangedSubview(artStack)
    mainStack.addArrangedSubview(detailLabel)
    mainStack.addArrangedSubview(tagStack)
    
    mainStack.axis = .vertical
    mainStack.spacing = 20
    mainStack.alignment = .fill
    mainStack.distribution = .fill
    mainStack.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func updateCellData(
    release: String,
    title: String,
    details: String,
    artImageUrl: String,
    tutorialType: TutorialType,
    durationTxt: String
  ) {
    releaseLabel.text = "Released on \(release)"
    titleLabel.text = title
    detailLabel.text = details
    
    switch tutorialType {
    case .article:
      typeTagView.iconImage = UIImage(systemName: "book.circle")
      typeTagView.backgroundColor = .article
    case .video:
      typeTagView.iconImage = UIImage(systemName: "video.circle")
      typeTagView.backgroundColor = .video
    case .both:
      break
    }
    typeTagView.title = tutorialType.rawValue
    
    durationTagView.iconImage = UIImage(systemName: "clock")
    durationTagView.title = durationTxt
    durationTagView.backgroundColor = .duration
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    let isLargeTextOn = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
    let orientation: NSLayoutConstraint.Axis = isLargeTextOn ? .vertical: .horizontal
    
    artStack.axis = orientation
    tagStack.axis = orientation
  }
}
