//
//  RWEmptyStateView.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-16.
//

import UIKit

class RWEmptyStateView: UIView {
  
  let messageLabel = RWLabel(textAlignment: .center, fontSize: 20, weight: .regular, textColor: .label)
  let logoImageView = RWImageView(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(message: NSAttributedString) {
    self.init(frame: .zero)
    self.messageLabel.attributedText = message
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubviews(messageLabel, logoImageView)
    configureMessageLabel()
    configureLogoImageView()
  }
  
  private func configureMessageLabel() {
    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel
    self.bringSubviewToFront(messageLabel)
    
    let padding: CGFloat = 70
    
    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      messageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
      messageLabel.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  private func configureLogoImageView() {
    logoImageView.image = UIImage(named: "logo")
    logoImageView.image = logoImageView.image!.withRenderingMode(.alwaysTemplate)
    logoImageView.tintColor = .tertiaryLabel
    logoImageView.transform = CGAffineTransform(rotationAngle: .pi/5)
    logoImageView.layer.borderColor = .none
    
    NSLayoutConstraint.activate([
      logoImageView.heightAnchor.constraint(equalToConstant: 100),
      logoImageView.widthAnchor.constraint(equalToConstant: 100),
      logoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
      logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -140)
    ])
  }
}
