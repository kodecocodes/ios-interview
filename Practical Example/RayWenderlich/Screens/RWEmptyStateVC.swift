//
//  RWEmptyStateVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-16.
//

import UIKit

class RWEmptyStateVC: UIViewController {
  
  var emptyStateView = RWEmptyStateView(message: NSAttributedString(string: "No item selected."))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
  }
  
  func configureViewController() {
    view.addSubview(emptyStateView)
    emptyStateView.pinToEdges(of: view)
    
  }
}
