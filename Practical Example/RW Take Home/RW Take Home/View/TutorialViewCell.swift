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
  let descriptionLabel = UILabel()
  let artWorkImage = UIImageView()
  
  let typeTagView = TagView()
  let durationTagView = TagView()
  
  let titleStack = UIStackView()
  let artStack = UIStackView()
  let tagStack = UIStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    backgroundView = UIView()
    backgroundView?.backgroundColor = .secondarySystemBackground
    backgroundView?.layer.cornerRadius = 10
    backgroundView?.layer.shadowColor = UIColor.black.cgColor
    backgroundView?.layer.shadowRadius = 5
    backgroundView?.layer.shadowOpacity = 0.2
    backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 5)
    
    
    releaseLabel.text = "Released on 23 Jul 2020"
    releaseLabel.font = .preferredFont(forTextStyle: .caption1)
    releaseLabel.adjustsFontForContentSizeCategory = true
    releaseLabel.textColor = .secondaryLabel
    releaseLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
    releaseLabel.numberOfLines = 1
    
    
    titleLabel.text = "Your second kotlin Android App Your second kotlin Android App"
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.textColor = .label
    titleLabel.numberOfLines = 2
    
    
    descriptionLabel.text = "Your second kotlin Android AppYour second kotlin Android App second kotlin Android App second Your second kotlin Android AppYour second kotlin Android App second kotlin Android App secondYour second kotlin Andro"
    descriptionLabel.font = .preferredFont(forTextStyle: .caption1)
    descriptionLabel.adjustsFontForContentSizeCategory = true
    descriptionLabel.textColor = .label
    descriptionLabel.numberOfLines = 2
    
    artWorkImage.image = #imageLiteral(resourceName: "artwork")
    artWorkImage.layer.cornerRadius = 6
    artWorkImage.clipsToBounds = true
    NSLayoutConstraint.activate([
      artWorkImage.heightAnchor.constraint(equalToConstant: 60),
      artWorkImage.widthAnchor.constraint(equalToConstant: 60)
    ])
    
    titleStack.addArrangedSubview(releaseLabel)
    titleStack.addArrangedSubview(titleLabel)
    titleStack.axis = .vertical
    titleStack.alignment = .leading
    titleStack.distribution = .fill
    titleStack.spacing = 0
    
    artStack.addArrangedSubview(titleStack)
    artStack.addArrangedSubview(artWorkImage)
    artStack.axis = .horizontal
    artStack.alignment = .leading
    artStack.spacing = 10
    
    typeTagView.backgroundColor = .article
    durationTagView.backgroundColor = .duration
    
    tagStack.addArrangedSubview(typeTagView)
    tagStack.addArrangedSubview(durationTagView)
    tagStack.alignment = .leading
    tagStack.distribution = .fill
    tagStack.spacing = 10
    
    
    let mainStack = UIStackView(arrangedSubviews: [artStack, descriptionLabel, tagStack])
    mainStack.axis = .vertical
    mainStack.spacing = 10
    mainStack.alignment = .leading
    mainStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(mainStack)
    
    NSLayoutConstraint.activate([
      mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
    
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    let isLargeTextOn = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
    
    
    
    if isLargeTextOn {
      artStack.axis = .vertical
      tagStack.axis = .vertical
    } else{
      
      artStack.axis = .horizontal
      tagStack.axis = .horizontal
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("storyboard is not supported")
  }
  
}
