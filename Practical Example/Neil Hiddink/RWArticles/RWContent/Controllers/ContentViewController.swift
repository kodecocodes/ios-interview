//
//  ContentViewController.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import UIKit

// Use Swift 5.0 or above.
// Use Auto Layout
// There should be no errors, warnings or crashes
// The app should compile and run. If it needs additional setup, include instructions in the README.

class ContentViewController: UIViewController {
    
    private var articles: [RWArticle] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RWClient.shared.getArticleDataAsJSON { (articles, error) in
            if let _ = error {
                // TODO: Alert the User
            }
            
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return self.articles.count
    }
    
}
