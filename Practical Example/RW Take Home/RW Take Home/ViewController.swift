//
//  ViewController.swift
//  RW Take Home
//
//  Created by Zoha on 7/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  var dataSource: UICollectionViewDiffableDataSource<String, Int>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(TutorialViewCell.self, forCellWithReuseIdentifier: TutorialViewCell.reuseIdentifier)
    collectionView.collectionViewLayout = createCompositionalLayout()
    createDataSource()
    reloadData()
  }
  
  
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    
    let layout = UICollectionViewCompositionalLayout {  sectionIndex, layoutEnvironment in
      
      let cellSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .estimated(150)
      )
      
      let layoutItem = NSCollectionLayoutItem(layoutSize: cellSize)
      
      let isWidthRegular = self.traitCollection.horizontalSizeClass  == .regular
      let isLargeTextOn = self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory
      let itemCount = (isWidthRegular && !isLargeTextOn) ? 2: 1
      
      let layoutGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: cellSize,
        subitem: layoutItem,
        count: itemCount
      )
      layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
      layoutGroup.interItemSpacing = .fixed(20)
      
      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.interGroupSpacing = 20
      
      return layoutSection
    }
    
    return layout
  }
  
  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<String, Int>(collectionView: collectionView) { collectionView, indexPath, app in
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialViewCell.reuseIdentifier, for: indexPath) as? TutorialViewCell else {
        fatalError("Unable to dequeue")
      }
      
      
      return cell
    }
  }
  
  func reloadData() {
    
    let sections = ["sections"]
    
    var snapshot = NSDiffableDataSourceSnapshot<String, Int>()
    snapshot.appendSections(sections)
    
    for section in sections {
      snapshot.appendItems([1,2,3,4,5,6,7,8,9], toSection: section)
    }
    
    dataSource?.apply(snapshot)
  }
  
}

