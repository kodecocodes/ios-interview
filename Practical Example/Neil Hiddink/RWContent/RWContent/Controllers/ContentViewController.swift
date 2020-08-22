//
//  ContentViewController.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    private var content: [RWContent] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RWClient.shared.getArticleDataAsJSON { (content, error) in
            if let _ = error {
                // TODO: Alert the user that an error occurred.
            }
            
            self.content = content
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RWContentTableViewCell") as? RWContentTableViewCell {
            let contentItem = content[indexPath.row]
            cell.titleLabel.text = contentItem.attributes.name
            cell.detailLabel.text = "\(contentItem.attributes.content_type.uppercased()) – " +
                                    "\(contentItem.attributes.difficulty?.uppercased() ?? "ANNOUNCEMENTS")"
                                    
            
            
            if let imageUrl = URL(string: contentItem.attributes.card_artwork_url) {
                let data: Data?
                do {
                    data = try Data(contentsOf: imageUrl)
                    cell.previewImageView.image = UIImage(data: data!)
                } catch let error {
                    debugPrint(error)
                    cell.previewImageView.image = UIImage(named: "Swift Logo - RW")
                }
            }
            
            cell.customizeLayer(cornerRadius: 10.0, borderColor: UIColor.black.cgColor, borderWidth: 2.0)
            
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content.count
    }
    
}
