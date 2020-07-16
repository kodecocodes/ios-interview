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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    titleLabel.text = "hello world"
    iconImageView.image = UIImage(systemName: "checkmark.circle")
    iconImageView.tintColor = .white
    
    addSubview(titleLabel)
    addSubview(iconImageView)
    
    titleLabel.font = .preferredFont(forTextStyle: .caption1)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.textColor = .white
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    self.translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 6
    clipsToBounds = true
    
    NSLayoutConstraint.activate([
      
      iconImageView.heightAnchor.constraint(equalToConstant: 16),
      iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
      iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      
      iconImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -5),
      
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
    
    ])
    
    backgroundColor = .article

  }
  
  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }
}


//class TagView: UILabel {
//
//  var paddingInset = UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5)
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//
//    let imageAttachment = NSTextAttachment()
//    let image = UIImage(systemName: "checkmark.circle")
//
//    imageAttachment.image = image?.withTintColor(.white).resized(to: CGSize(width: 16, height: 16))
//
//    let fullString = NSMutableAttributedString()
//    fullString.append(NSAttributedString(attachment: imageAttachment))
//    fullString.append(NSAttributedString(string: " 2 hrs, 5 mins"))
//    attributedText = fullString
//
//    backgroundColor = .systemRed
//
//
//    font = .preferredFont(forTextStyle: .caption1)
//    adjustsFontForContentSizeCategory = true
//    textColor = .white
//    layer.cornerRadius = 6
//    clipsToBounds = true
//
//  }
//
//
//  required init?(coder: NSCoder) {
//    fatalError("Storyboard not supported")
//  }
//
//  override func drawText(in rect: CGRect) {
//    super.drawText(in: rect.inset(by: paddingInset))
//  }
//
//  override var intrinsicContentSize: CGSize {
//    get {
//      var contentSize = super.intrinsicContentSize
//      contentSize.height += paddingInset.top + paddingInset.bottom
//      contentSize.width += paddingInset.left + paddingInset.right
//      return contentSize
//    }
//  }
//}
//
//extension UIImage {
//    func resized(to size: CGSize) -> UIImage {
//        return UIGraphicsImageRenderer(size: size).image { _ in
//            draw(in: CGRect(origin: .zero, size: size))
//        }
//    }
//}
