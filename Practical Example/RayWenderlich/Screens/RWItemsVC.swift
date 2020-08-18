//
//  RWItemsVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

protocol RWItemsVCDelegate: class {
  func didSelectVC(with title: String)
}

class RWItemsVC: UIViewController {
  
  enum Section { case main }
  
  weak var delegate: RWItemsVCDelegate!
  
  var collectionView: UICollectionView!
  var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
  var dataSource: UICollectionViewDiffableDataSource<Section, String>!
  
  var items: [String] = ["Library", "Downloads", "My Tutorials"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureCollectionView()
    configureCellRegistration()
    configureDataSource()
    updateData(with: self.items)
  }
  
  func configureViewController() {
    
    view.backgroundColor = .secondarySystemBackground
    navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
    title = "raywenderlich.com"
  }
  
  func configureCollectionView() {
    let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    view.addSubview(collectionView)
    collectionView.pinToEdges(of: view)
    collectionView.backgroundColor = .secondarySystemBackground
    
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
//    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  func configureCellRegistration() {
    cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>(handler: { cell, indexPath, name in
      var configuration = UIListContentConfiguration.cell()
      
      configuration.text = name
      configuration.imageProperties.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
      
      switch indexPath.row {
      case 0:
        configuration.image = Images.library
      case 1:
        configuration.image = Images.downloads
      default:
        configuration.image = Images.person
      }
      
      cell.contentConfiguration = configuration
      cell.backgroundConfiguration = UIBackgroundConfiguration.listSidebarCell()
    })
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, name -> UICollectionViewCell? in
      return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: name)
    })
  }
  
  func updateData(with items: [String]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
}

//extension RWItemsVC: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return items.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
//    var contentConfiguration = UIListContentConfiguration.cell()
//    contentConfiguration.text = items[indexPath.row]
//
//    if indexPath.row == 0 {
//      contentConfiguration.image = Images.library
//    } else if indexPath.row == 1 {
//      contentConfiguration.image = Images.downloads
//    } else {
//      contentConfiguration.image = Images.person
//    }
//
//    cell.contentConfiguration = contentConfiguration
//    cell.backgroundConfiguration = UIBackgroundConfiguration.listSidebarCell()
//    cell.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
//
//    return cell
//  }
//}

extension RWItemsVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let destVCTitle = items[indexPath.item]
    delegate.didSelectVC(with: destVCTitle)
  }
}
