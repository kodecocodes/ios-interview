//
//  ViewController+Ext.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

extension TutorialViewController {
  
  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
