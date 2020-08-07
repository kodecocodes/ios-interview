//
//  DownloadsViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class DownloadsVC: UIViewController {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    static var items: [Item] = []
    var filteredItems: [Item] = []
    
    var isSearching: Bool = false
    var isAdding: Bool = false
    var isRemoving: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDownloads()
        configureViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDownloads(with: DownloadsVC.items)
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(Images.filter, for: .bookmark, state: .normal)
        
        searchController.searchBar.placeholder = "Search..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    func updateUI(with completed: Item) {
        if isRemoving {
            DownloadsVC.items.removeAll { $0.id == completed.id }
        } else if isAdding {
            DownloadsVC.items.append(completed)
        }
        updateData(on: DownloadsVC.items)
    }
    
    func updateData(on items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func getDownloads() {
        PersistenceManager.retreiveItems(for: Keys.downloads) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloads):
                DownloadsVC.items = downloads
                self.updateData(on: downloads)
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
    
    func updateDownloads(with items: [Item]) {
        for item in items {
            PersistenceManager.updateItems(for: Keys.downloads, with: item, actionType: .add) { error in
                guard let _ = error else {
                    print("Successfully updated persisted downloads!")
                    return
                }
            }
        }
    }
}

extension DownloadsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeItems = isSearching ? filteredItems : DownloadsVC.items
        let destVC = ItemDetailVC(with: activeItems[indexPath.row])
        
        navigationController?.pushViewController(destVC, animated: true)
    }
}

extension DownloadsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height: CGFloat = 170
        
        return CGSize(width: width, height: height)
    }
}

extension DownloadsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredItems.removeAll()
            updateData(on: DownloadsVC.items)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredItems = DownloadsVC.items.filter { $0.attributes.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredItems)
    }
}

extension DownloadsVC: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let destVC = FiltersVC()
        destVC.title = "Filters"
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension DownloadsVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
        
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            let download = DownloadsVC.items[indexPath.row]
            
            let share = UIAction(title: "Share Link", image: Images.share) { [weak self] action in
                guard let self = self else { return }
                
                DispatchQueue.main.async { UIHelper.createActivityController(for: download, collectionView: self.collectionView, indexPath: indexPath, for: self) }
            }

            
            let remove = UIAction(title: "Remove from Downloads", image: Images.removeDownload, attributes: .destructive) { action in
                let updatedDownload = Item(id: download.id, type: download.type, attributes: download.attributes, isDownloaded: false, isBookmarked: download.isBookmarked!)
                
                PersistenceManager.updateItems(for: Keys.downloads, with: updatedDownload, actionType: .remove) { [weak self] error in
                    guard let self = self else { return }
                    
                    self.isRemoving = true
                    
                    guard let error = error else {
                        DispatchQueue.main.async { UIHelper.createAlertController(title: "Removed", message: "Successfully removed from downloads!", in: self) }
                        self.updateUI(with: download)
                        self.isRemoving = false
                        return
                    }
                    
                    DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
                }
                
                CourseInfoVC.item = updatedDownload
            }
            
            return UIMenu(title: "Menu", children: [share, remove])
        }
            
        return configuration
    }
}
