//
//  ContentTableViewCell.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import UIKit

class RWContentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentTypeLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    func customizeLayer(cornerRadius: CGFloat, borderColor: CGColor, borderWidth: CGFloat) {
        previewImageView.layer.cornerRadius = cornerRadius
        previewImageView.layer.borderColor = borderColor
        previewImageView.layer.borderWidth = borderWidth
    }
}
