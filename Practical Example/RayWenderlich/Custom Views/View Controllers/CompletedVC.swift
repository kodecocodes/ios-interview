//
//  CompletedVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-03.
//

import UIKit

protocol CompletedVCDelegate: class {
  func didPassItem(item: Item)
}

class CompletedVC: UIViewController {
  
  weak var delegate: CompletedVCDelegate!
  
  enum Section { case main }
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  static var items: [Item] = []
  var filteredItems: [Item] = []
  
  var isAdding: Bool = false
  var isRemoving: Bool = false
  
  init(with items: [Item], delegate: CompletedVCDelegate) {
    super.init(nibName: nil, bundle: nil)
    CompletedVC.items = MyTutorialsVC.completedItems
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureCollectionView()
    configureDataSource()
    getCompleted()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getCompleted()
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.pinToEdges(of: view)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .secondarySystemBackground
    
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseID)
    collectionView.delegate = self
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
      cell.setPersistedCell(with: item)
      
      return cell
    })
  }
  
  func updateUI(with completed: Item) {
    if isRemoving {
      CompletedVC.items.removeAll { $0.id == completed.id }
    } else if isAdding {
      CompletedVC.items.append(completed)
    }
    updateData(on: CompletedVC.items)
  }
  
  func updateData(on completed: [Item]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.main])
    snapshot.appendItems(completed)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
  
  func getCompleted() {
    PersistenceManager.retreiveItems(for: Keys.completed) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let completed):
        CompletedVC.items = completed
        self.updateData(on: completed)
      case .failure(let error):
        DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
      }
    }
  }
  
  func updateCompleted(with items: [Item]) {
    for item in items {
      PersistenceManager.updateItems(for: Keys.completed, with: item, actionType: .add) { error in
        guard let _ = error else {
          print("Successfully updated persisted completed courses!")
          return
        }
      }
    }
  }
  
}

extension CompletedVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let destVC = ItemDetailVC(with: CompletedVC.items[indexPath.row])
    
    if SceneDelegate.windowInterfaceOrientation!.isPortrait {
      navigationController?.pushViewController(destVC, animated: true)
    } else {
      delegate.didPassItem(item: CompletedVC.items[indexPath.row])
    }
  }
}

extension CompletedVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.width - 20
    let height: CGFloat = 170
    
    return CGSize(width: width, height: height)
  }
}

extension CompletedVC: UIContextMenuInteractionDelegate {
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    return nil
  }
  
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
      let completed = CompletedVC.items[indexPath.row]
      
      let share = UIAction(title: "Share Link", image: Images.share) { [weak self] action in
        guard let self = self else { return }
        
        DispatchQueue.main.async { UIHelper.createActivityController(for: completed, collectionView: self.collectionView, indexPath: indexPath, for: self) }
      }
      
      
      let remove = UIAction(title: "Remove from Completed", image: Images.removeCompleted, attributes: .destructive) { action in
        PersistenceManager.updateItems(for: Keys.completed, with: completed, actionType: .remove) { [weak self] error in
          guard let self = self else { return }
          
          self.isRemoving = true
          
          guard let error = error else {
            DispatchQueue.main.async { UIHelper.createAlertController(title: "Removed", message: "Successfully removed from completed!", in: self) }
            self.updateUI(with: completed)
            self.isRemoving = false
            return
          }
          
          DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
        }
      }
      
      return UIMenu(title: "Menu", children: [share, remove])
    }
    
    return configuration
  }
}
