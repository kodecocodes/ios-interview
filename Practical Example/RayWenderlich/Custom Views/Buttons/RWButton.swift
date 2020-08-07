//
//  RWButton.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class RWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String?, backgroundImage: UIImage?, backgroundColor: UIColor, tintColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.setTitle(title, for: .normal)
        self.setBackgroundImage(backgroundImage, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(tintColor: UIColor) {
        self.tintColor = tintColor
    }
}
