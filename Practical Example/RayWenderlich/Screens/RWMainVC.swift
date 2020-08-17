//
//  RWMainVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWMainVC: UIViewController {
  
  let windowInterfaceOrientation = SceneDelegate.windowInterfaceOrientation!
  
  var tabBarView = UIView()
  var splitView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
  }
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    
    coordinator.animate(alongsideTransition: { [weak self] context in
      guard let self = self else{ return }
      
      self.configureViewController()
    })
  }
  
  func configureViewController() {
    guard let interfaceOrientation = SceneDelegate.windowInterfaceOrientation else { return }
    
    if interfaceOrientation.isPortrait {
      self.splitView.removeFromSuperview()
      self.view.addSubview(self.tabBarView)
      self.tabBarView.pinToEdges(of: self.view)
      
      self.add(childVC: RWTabBarController(), to: self.tabBarView)
    } else {
      self.tabBarView.removeFromSuperview()
      self.view.addSubview(self.splitView)
      self.splitView.pinToEdges(of: self.view)
      
      self.add(childVC: RWSplitViewController(style: .tripleColumn), to: self.splitView)
    }
  }
}
