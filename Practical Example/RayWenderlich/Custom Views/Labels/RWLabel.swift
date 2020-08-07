//
//  RWLabel.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class RWLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
