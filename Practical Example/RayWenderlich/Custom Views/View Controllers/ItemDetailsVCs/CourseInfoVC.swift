//
//  CourseInfoVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class CourseInfoVC: UIViewController {
    
    var item: Item!
    
    var technologyLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    var titleLabel = RWLabel(textAlignment: .left, fontSize: 24, weight: .bold, textColor: .label)
    var subtitleLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    var downloadButton = RWButton(title: nil, backgroundImage: Images.downloads, backgroundColor: .clear, tintColor: .secondaryLabel)
    var bookmarkButton = RWButton(title: nil, backgroundImage: Images.bookmark, backgroundColor: .clear, tintColor: .secondaryLabel)
    var descriptionLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .regular, textColor: .secondaryLabel)
    var contributorLabel = RWLabel(textAlignment: .left, fontSize: 14, weight: .regular, textColor: .secondaryLabel)

    init(with item: Item) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
        
        technologyLabel.text = item.attributes.technologyTripleString.uppercased()
        titleLabel.text = item.attributes.name
        titleLabel.numberOfLines = 2
        subtitleLabel.text = "\(String(describing: item.attributes.releasedAt.convertToDate()!.convertToMonthDayYearFormat())) • \(item.attributes.difficulty?.localizedCapitalized ?? "N/A") • \(item.attributes.contentType.localizedCapitalized) \(item.attributes.duration.convertToDuration())"
        
        descriptionLabel.text = item.attributes.descriptionPlainText
        descriptionLabel.numberOfLines = 3
        
        contributorLabel.text = "By \(item.attributes.contributorString)"
        contributorLabel.numberOfLines = 3
        
        downloadButton.set(tintColor: item.isDownloaded! ? UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1) : .secondaryLabel)
        bookmarkButton.set(tintColor: item.isBookmarked! ? UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1) : .secondaryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    func layoutUI() {
        view.addSubviews(
            technologyLabel,
            titleLabel,
            subtitleLabel,
            downloadButton,
            bookmarkButton,
            descriptionLabel,
            contributorLabel
        )
        
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            technologyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            technologyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            technologyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            technologyLabel.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.topAnchor.constraint(equalTo: technologyLabel.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: technologyLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: technologyLabel.trailingAnchor),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 60),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            subtitleLabel.leadingAnchor.constraint(equalTo: technologyLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: technologyLabel.trailingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            downloadButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: padding),
            downloadButton.leadingAnchor.constraint(equalTo: technologyLabel.leadingAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 30),
            downloadButton.widthAnchor.constraint(equalToConstant: 30),
            
            bookmarkButton.topAnchor.constraint(equalTo: downloadButton.topAnchor),
            bookmarkButton.leadingAnchor.constraint(equalTo: downloadButton.trailingAnchor, constant: padding),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: technologyLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: technologyLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 72),
            
            contributorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            contributorLabel.leadingAnchor.constraint(equalTo: technologyLabel.leadingAnchor),
            contributorLabel.trailingAnchor.constraint(equalTo: technologyLabel.trailingAnchor),
            contributorLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 54)
            
        ])
    }
    
    func updateUI() {
        if !item.isDownloaded! {
            downloadButton.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
            item.isDownloaded = true
        } else {
            DownloadsVC.items.removeAll { $0.id == item.id }
            downloadButton.tintColor = .secondaryLabel
            item.isDownloaded = false
        }
        
        if !item.isBookmarked! {
            bookmarkButton.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
            item.isBookmarked = true
        } else {
            bookmarkButton.tintColor = .secondaryLabel
            item.isBookmarked = false
        }
    }

    @objc func downloadButtonTapped() {
        if !item.isDownloaded! {
            DownloadsVC.items.append(self.item)
            downloadButton.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
            item.isDownloaded = true
            addToDownloads(with: item)
        } else {
            DownloadsVC.items.removeAll { $0.id == item.id }
            downloadButton.tintColor = .secondaryLabel
            item.isDownloaded = false
            removeFromDownloads(with: item)
        }
    }
    
    func addToDownloads(with download: Item) {
        PersistenceManager.updateItems(for: Keys.downloads, with: download, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Downloaded!", message: "Successfully added to downloads!", in: self) }
                return
            }
            
            DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
        }
    }
    
    func removeFromDownloads(with download: Item) {
        PersistenceManager.updateItems(for: Keys.downloads, with: download, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Removed", message: "Successfully removed from downloads!", in: self) }
                return
            }
            
            DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
        }
    }
    
    @objc func bookmarkButtonTapped() {
        if !item.isBookmarked! {
            MyTutorialsVC.bookmarkedItems.append(self.item)
            bookmarkButton.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
            item.isBookmarked = true
            addToBookmarks(with: item)
        } else {
            MyTutorialsVC.bookmarkedItems.removeAll { $0.id == item.id }
            bookmarkButton.tintColor = .secondaryLabel
            item.isBookmarked = false
            removeFromBookmarks(with: item)
        }
    }
    
    func addToBookmarks(with bookmark: Item) {
        PersistenceManager.updateItems(for: Keys.bookmarks, with: bookmark, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Bookmarked!", message: "Successfully added to bookmarks!", in: self) }
                return
            }
            
            DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
        }
    }
    
    func removeFromBookmarks(with bookmark: Item) {
        PersistenceManager.updateItems(for: Keys.bookmarks, with: bookmark, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Removed", message: "Successfully removed from bookmarks!", in: self) }
                return
            }
            
            DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
        }
    }
}
