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

   func getArticles() {
    networkService.fetchTutorials(ofType: .article) {  (result) in
      guard let result = try? result.get() else { fatalError()}

      self.articles = result.sorted(by: <)
      self.tutorials = result.sorted(by: <)
      self.reloadDataOnMainThread()
    }
  }

   func getVideos() {
    networkService.fetchTutorials(ofType: .video) {  (result) in
      guard let result = try? result.get() else { fatalError()}

      self.videos = result.sorted(by: <)
    }
  }
}
