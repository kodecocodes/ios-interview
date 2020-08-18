//
//  ViewController.swift
//  RWArticles
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import UIKit

// Use Swift 5.0 or above.
// Use Auto Layout
// There should be no errors, warnings or crashes
// The app should compile and run. If it needs additional setup, include instructions in the README.

class ViewController: UIViewController {
    
    private let articles: [RWArticle] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RWClient.shared.getArticleDataAsJSON()
    }
}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Delegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Data Source
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RWContentTableViewCell") as? RWContentTableViewCell {
            cell.titleLabel.text = "iOS Interview Prep"
            cell.detailLabel.text = "Articles"
            cell.imageView?.image = UIImage(named: "Swift Logo - RW")
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
