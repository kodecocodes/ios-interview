//
//  InProgressVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-03.
//

import UIKit

class InProgressVC: UIViewController {

    var contentLabel = RWLabel(textAlignment: .center, fontSize: 24, weight: .bold, textColor: UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1))

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    func layoutUI() {
        view.addSubview(contentLabel)
        contentLabel.text = "Courses In Progress"
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            contentLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
