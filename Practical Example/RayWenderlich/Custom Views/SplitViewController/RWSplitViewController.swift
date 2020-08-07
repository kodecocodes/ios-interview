//
//  RWSplitViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        
        viewControllers = [createLibraryVC(), createTabBarController()]
        preferredDisplayMode = .oneBesideSecondary
    }
    
    func createListViewController() -> UICollectionViewController {
        let layout = UICollectionViewFlowLayout()
        
        
        let collectionVC = UICollectionViewController(collectionViewLayout: layout)
        
        return collectionVC
    }
    
    func createTabBarController() -> RWTabBarController {
        let tabBarController = RWTabBarController()
        view.backgroundColor = .secondarySystemBackground
        UITabBar.appearance().tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        
        return tabBarController
    }
    
    func createLibraryVC() -> UINavigationController {
        let libraryVC = LibraryVC()
        libraryVC.title = "Library"
        libraryVC.tabBarItem = UITabBarItem(title: "Library", image: Images.library, tag: 0)
        
        return UINavigationController(rootViewController: libraryVC)
    }
    
    func createDownloadsVC() -> UINavigationController {
        let downloadsVC = DownloadsVC()
        downloadsVC.title = "Downloads"
        downloadsVC.tabBarItem = UITabBarItem(title: "Downloads", image: Images.downloads, tag: 1)
        
        return UINavigationController(rootViewController: downloadsVC)
    }
    
    func createMyTurorialsVC() -> UINavigationController {
        let myTutorialsVC = MyTutorialsVC()
        myTutorialsVC.title = "My Tutorials"
        myTutorialsVC.tabBarItem = UITabBarItem(title: "My Tutorials", image: Images.person, tag: 2)
        
        return UINavigationController(rootViewController: myTutorialsVC)
    }
}
