//
//  RWSplitViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWSplitViewController: UISplitViewController {
  
  enum SuplementaryViewType { case library, downloads, myTutorials }
  
  var suplementaryViewTitle = "Library"
  var item: Item!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
  }
  
  func configureViewController() {
    view.backgroundColor = .secondarySystemBackground
    
    preferredSplitBehavior = .displace
    preferredPrimaryColumnWidthFraction = 1/4
    preferredDisplayMode = .twoOverSecondary
    navigationController?.isNavigationBarHidden = true
    
    setViewController(createListViewController(), for: .primary)
    setViewController(createSuplementaryViewController(with: suplementaryViewTitle), for: .supplementary)
    setViewController(createEmptyStateViewController(), for: .secondary)
  }
  
  func createListViewController() -> RWItemsVC {
    
    let collectionVC = RWItemsVC()
    collectionVC.delegate = self
    
    return collectionVC
  }
  
  func createSuplementaryViewController(with title: String) -> UIViewController {
    var destVC = UIViewController()
    
//    switch type {
//    case .library:
//      break
//    case .downloads:
//      break
//    case .myTutorials:
//      break
//    }
    
    if title == "Library" {
      let libraryVC = LibraryVC()
      libraryVC.title = title
      libraryVC.delegate = self
      
      destVC = libraryVC
    } else if title == "Downloads" {
      let downloadsVC = DownloadsVC()
      downloadsVC.title = title
      downloadsVC.delegate = self
      
      destVC = downloadsVC
    } else if title == "My Tutorials" {
      let myTutorialsVC = MyTutorialsVC()
      myTutorialsVC.title = title
      myTutorialsVC.delegate = self
      
      destVC = myTutorialsVC
    }
    
    return destVC
  }
  
  func createEmptyStateViewController() -> UIViewController {
    let destVC = RWEmptyStateVC()
    
    return destVC
  }
  
  func createSecondaryViewController(with item: Item) -> UIViewController {
    let destVC = ItemDetailVC(with: item)
    
    return destVC
  }
  
}

extension RWSplitViewController: RWItemsVCDelegate {
  func didSelectVC(with title: String) {
    suplementaryViewTitle = title
    
    self.setViewController(createSuplementaryViewController(with: title), for: .supplementary)
  }
}

extension RWSplitViewController: LibraryVCDelegate, DownloadsVCDelegate, MyTutorialsVCDelegate {
  func didPassItem(item: Item) {
    self.item = item
    
    showDetailViewController(createSecondaryViewController(with: self.item), sender: self)
  }
}
