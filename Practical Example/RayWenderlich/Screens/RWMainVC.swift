//
//  RWMainVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWMainVC: UIViewController {
  
  var tabBarVC = RWTabBarController()
  var splitVC = RWSplitViewController(style: .tripleColumn)
  
  var splitView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
  }

  
  func configureViewController() {
    view.addSubview(splitView)
    splitView.pinToEdges(of: view)

    self.add(childVC: splitVC, to: self.splitView)
    splitVC.setViewController(tabBarVC, for: .compact)
  }
}
