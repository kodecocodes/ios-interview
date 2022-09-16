//
//  ResourceView.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import Foundation
import UIKit

class ResourceView: UITableViewCell {
    static let identifier = "ResourceView"
    
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
}
