//
//  MyTutorialsViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

protocol MyTutorialsVCDelegate: class {
  func didPassItem(item: Item)
}

class MyTutorialsVC: UIViewController {
  
  weak var delegate: MyTutorialsVCDelegate!
    
    var segmentedControl: UISegmentedControl!
    var inProgressView = UIView()
    var completedView = UIView()
    var bookmarksView = UIView()
    
    static var bookmarkedItems: [Item] = []
    static var completedItems: [Item] = []
    static var inProgressItems: [Item] = []
    var filteredItems : [Item] = []
    var items: [Item] = []

    var isFiltered: Bool = false
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSegmentedControl()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBookmarksVC(with: MyTutorialsVC.bookmarkedItems)
        configureInProgressVC(with: MyTutorialsVC.inProgressItems)
        configureCompletedVC(with: MyTutorialsVC.completedItems)
        configureViewController()
        
        getCompleted()
        getBookmarks()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let changeUsername = UIAction(title: "Change username", image: Images.username) { action in
            print(action.title)
        }
        
        let changeProfilePicture = UIAction(title: "Change profile picture", image: Images.profilePicture) { action in
            print(action.title)
        }
        
        let logOut = UIAction(title: "Log Out", image: Images.logOut, attributes: .destructive) { action in
            print(action.title)
        }
        
        let logOutMenu = UIMenu(title: "", options: .displayInline, children: [logOut])
        
        let settingsMenu = UIMenu(title: "Settings", options: .displayInline, children: [changeUsername, changeProfilePicture, logOutMenu])
        
        let settingsButton = UIBarButtonItem(title: nil, image: Images.settings, menu: settingsMenu)
        navigationItem.rightBarButtonItem = settingsButton
    }
        
    func layoutUI() {
        view.addSubviews(
            inProgressView,
            completedView,
            bookmarksView
        )
        inProgressView.translatesAutoresizingMaskIntoConstraints = false
        completedView.translatesAutoresizingMaskIntoConstraints = false
        bookmarksView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookmarksView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            bookmarksView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bookmarksView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bookmarksView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            inProgressView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            inProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            inProgressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            completedView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            completedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            completedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            completedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureBookmarksVC(with bookmarks: [Item]) {
        self.add(childVC: BookmarksVC(with: bookmarks, delegate: self), to: self.bookmarksView)
    }
    
    func configureInProgressVC(with inProgress: [Item]) {
        self.add(childVC: InProgressVC(), to: self.inProgressView)
    }
    
    func configureCompletedVC(with completed: [Item]) {
        self.add(childVC: CompletedVC(with: completed, delegate: self), to: self.completedView)
    }
    
    func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["In Progress", "Completed", "Bookmarks"])
        segmentedControl.selectedSegmentIndex = 2
        segmentedControl.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)
    
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func changeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            inProgressView.isHidden = false
            items = MyTutorialsVC.inProgressItems
            configureInProgressVC(with: items)
            
            completedView.isHidden = true
            bookmarksView.isHidden = true
        case 1:
            inProgressView.isHidden = true
            
            completedView.isHidden = false
            items = MyTutorialsVC.completedItems
            configureCompletedVC(with: items)
            
            bookmarksView.isHidden = true
        default:
            inProgressView.isHidden = true
            completedView.isHidden = true
            
            bookmarksView.isHidden = false
            items = MyTutorialsVC.bookmarkedItems
            configureBookmarksVC(with: items)
        }
    }
    
    func getBookmarks() {
        PersistenceManager.retreiveItems(for: Keys.bookmarks) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let bookmarks):
                MyTutorialsVC.bookmarkedItems = bookmarks
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
    
    func getCompleted() {
        PersistenceManager.retreiveItems(for: Keys.completed) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let completed):
                MyTutorialsVC.completedItems = completed
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
}

extension MyTutorialsVC: BookmarksVCDelegate, CompletedVCDelegate {
  func didPassItem(item: Item) {
    delegate.didPassItem(item: item)
  }
}
