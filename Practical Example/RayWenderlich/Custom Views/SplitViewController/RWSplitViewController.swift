//
//  RWSplitViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWSplitViewController: UISplitViewController {
    
    var secondaryViewTitle = "Library"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        
        preferredSplitBehavior = .displace
        preferredPrimaryColumnWidthFraction = 1/6
        preferredDisplayMode = .oneBesideSecondary
        navigationController?.isNavigationBarHidden = true
        
        setViewController(createListViewController(), for: .primary)
        setViewController(createSecondaryViewController(with: secondaryViewTitle), for: .secondary)
    }
    
    func createListViewController() -> RWItemsVC {
        
        let collectionVC = RWItemsVC()
        collectionVC.delegate = self
        
        return collectionVC
    }
    
    func createSecondaryViewController(with title: String) -> UINavigationController {
        var navController = UINavigationController()
        
        if title == "Library" {
            let libraryVC = LibraryVC()
            libraryVC.title = title
            
            navController = UINavigationController(rootViewController: libraryVC)
        } else if title == "Downloads" {
            let downloadsVC = DownloadsVC()
            downloadsVC.title = title
            
            navController = UINavigationController(rootViewController: downloadsVC)
        } else if title == "My Tutorials" {
            let myTutorialsVC = MyTutorialsVC()
            myTutorialsVC.title = title
            
            navController = UINavigationController(rootViewController: myTutorialsVC)
        }
        
        return navController
    }
}

extension RWSplitViewController: RWItemsVCDelegate {
    func didSelectVC(with title: String) {
        secondaryViewTitle = title

        self.setViewController(createSecondaryViewController(with: title), for: .secondary)
    }
}
