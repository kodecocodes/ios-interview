//
//  ContentViewController.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import UIKit
import SafariServices

class ContentViewController: UIViewController {
    
    private var content: [RWContent] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    enum Filter {
        case ARTICLES_ONLY, VIDEOS_ONLY, ALL_CONTENT
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let organizeButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButton))
        navigationItem.rightBarButtonItem = organizeButton
        organizeButton.tintColor = .gray
        
        refresh(Filter.ALL_CONTENT)
    }
    
    @objc func filterButton() {
        let alertVC = UIAlertController(title: "Filtering", message: "Please select a filter to apply.", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Articles Only", style: .default, handler: { action in
            self.perform(#selector(self.refreshContentArticleContentOnly))
        }))
        alertVC.addAction(UIAlertAction(title: "Videos Only", style: .default, handler: { action in
            self.perform(#selector(self.refreshContentVideoContentOnly))
        }))
        alertVC.addAction(UIAlertAction(title: "Clear Filters", style: .default, handler: { action in
            self.perform(#selector(self.refreshContentNoFilter))
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }
    
    @objc func refreshContentArticleContentOnly() { refresh(Filter.ARTICLES_ONLY) }
    @objc func refreshContentVideoContentOnly() { refresh(Filter.VIDEOS_ONLY) }
    @objc func refreshContentNoFilter() { refresh(Filter.ALL_CONTENT) }
    
    // MARK: - Helper Methods
    
    private func refresh(_ filter: Filter) {
        let client = RWClient()
        let dispatchGroup = DispatchGroup()
        let activityIndicator = UIActivityIndicatorView()
        let container: UIView = UIView()
        
        dispatchGroup.enter()
        content = []
        if filter == .ARTICLES_ONLY {
            applyArticlesOnlyFilter(client, activityIndicator, container)
        } else if filter == .VIDEOS_ONLY {
            applyVideosOnlyFilter(client, activityIndicator, container)
        } else {
            clearAllFilters(client, activityIndicator, container)
        }
        dispatchGroup.leave()
    }
    
    fileprivate func applyArticlesOnlyFilter(_ client: RWClient, _ activityIndicator: UIActivityIndicatorView, _ container: UIView) {
        client.getArticleContentAsJSON { (content, error) in
            DispatchQueue.main.async { self.setupAndDisplay(activityIndicator: activityIndicator, container: container) }
            if let error = error { debugPrint(error) }
            self.content += content
            DispatchQueue.main.async {
                self.content = content.sorted { (first, second) -> Bool in
                    first.attributes.released_at < second.attributes.released_at
                }
                self.tableView.reloadData()
                activityIndicator.stopAnimating()
                container.removeFromSuperview()
            }
        }
    }
    
    fileprivate func applyVideosOnlyFilter(_ client: RWClient, _ activityIndicator: UIActivityIndicatorView, _ container: UIView) {
        client.getVideoContentAsJSON { (content, error) in
            DispatchQueue.main.async { self.setupAndDisplay(activityIndicator: activityIndicator, container: container) }
            if let error = error { debugPrint(error) }
            self.content += content
            DispatchQueue.main.async {
                self.content = content.sorted { (first, second) -> Bool in
                    first.attributes.released_at < second.attributes.released_at
                }
                self.tableView.reloadData()
                activityIndicator.stopAnimating()
                container.removeFromSuperview()
            }
        }
    }
    
    private func clearAllFilters(_ client: RWClient, _ activityIndicator: UIActivityIndicatorView, _ container: UIView) {
        client.getArticleContentAsJSON { (content, error) in
            DispatchQueue.main.async { self.setupAndDisplay(activityIndicator: activityIndicator, container: container) }
            if let error = error { debugPrint(error) }
            self.content += content
            client.getVideoContentAsJSON { (content, error) in
                if let error = error { debugPrint(error) }
                self.content += content
                DispatchQueue.main.async {
                    self.content = content.sorted { (first, second) -> Bool in
                        first.attributes.released_at < second.attributes.released_at
                    }
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                    container.removeFromSuperview()
                }
            }
        }
    }
    
    private func setupAndDisplay(activityIndicator: UIActivityIndicatorView, container: UIView) {
        // Adapted from https://coderwall.com/p/su1t1a/ios-customized-activity-indicator-with-swift
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        container.layer.cornerRadius = 10
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(white: 0.3, alpha: 0.0)
        loadingView.clipsToBounds = true

        activityIndicator.style = .large
        activityIndicator.color = .systemGray6
        activityIndicator.frame = loadingView.frame
        activityIndicator.center = CGPoint(x: loadingView.frame.width / 2, y: loadingView.frame.height / 2)

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Delegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let baseURL = "https://www.raywenderlich.com"
        
        guard let path = (content[indexPath.row].links["self"] as? String)?.dropFirst(41) else { fatalError() }
        guard let url = URL(string: baseURL + path) else { fatalError() }
            
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = false
            
        // https://www.hackingwithswift.com/read/32/3/how-to-use-sfsafariviewcontroller-to-browse-a-web-page
        let safariVC = SFSafariViewController(url: url, configuration: configuration)
        safariVC.modalPresentationStyle = .overFullScreen
        safariVC.preferredControlTintColor = .gray
        present(safariVC, animated: true)
    }
    
    // MARK: - Data Source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RWContentTableViewCell") as? RWContentTableViewCell {
            let contentItem = content[indexPath.row]
            cell.titleLabel.text = contentItem.attributes.name
            cell.descriptionLabel.text = contentItem.attributes.description_plain_text
            cell.contentTypeLabel.text = "\(contentItem.attributes.content_type.uppercased()) – " +
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
