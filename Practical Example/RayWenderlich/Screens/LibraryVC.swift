//
//  ViewController.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

protocol LibraryVCDelegate: class {
  func didPassItem(item: Item)
}

class LibraryVC: RWDataLoadingVC {
  
  weak var delegate: LibraryVCDelegate!
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var refreshControl: UIRefreshControl!
    
    var contentLabel = RWLabel(textAlignment: .left, fontSize: 20, weight: .regular, textColor: .secondaryLabel)
    var sortButton = RWButton(title: "Newest", backgroundImage: nil, backgroundColor: .clear, tintColor: .secondaryLabel)
    
    var items: [Item] = []
    var fetchedItems: [Item] = []
    var filteredItems: [Item] = []
    var sortedItems: [Item] = []
    var downloadedItems: [Item] = []
    var bookmarkedItems: [Item] = []
    
    var isFiltered: Bool = false
    var isSearching: Bool = false
    var isSorted: Bool = false
    var isAdding: Bool = false
    var isRemoving: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureRefreshControl()
        
        configureContentLabel()
        configureSortButton()
        
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        
        fetchContent()
        sortByDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureViewController()
        getDownloads()
        getBookmarks()
    }

    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
    }

    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func configureSortButton() {
        sortButton.setImage(Images.sort, for: .normal)
        sortButton.setTitleColor(.secondaryLabel, for: .normal)
        view.addSubview(sortButton)
        
        sortButton.addTarget(self, action: #selector(sortButtonTapped(_:)), for: .touchUpInside)

        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            sortButton.heightAnchor.constraint(equalToConstant: 44),
            sortButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureContentLabel() {
        contentLabel.text = "All"
        view.addSubview(contentLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            contentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            contentLabel.widthAnchor.constraint(equalToConstant: 150),
            contentLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: sortButton.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.addSubview(refreshControl)
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseID)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
            cell.setLibraryCell(with: item)
            
            return cell
        })
    }
    
    func updateUI(with items: [Item]) {
        self.items.append(contentsOf: items)
        updateData(with: self.items)
    }
 
    func updateData(with items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
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
    
    @objc func sortButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Newest" {
            sortByPopularity()
        } else {
            sortByDate()
        }
    }

    @objc func sortByPopularity() {
        let activeItems = isFiltered ? filteredItems : items
        sortedItems = activeItems.sorted { $0.attributes.popularity > $1.attributes.popularity }
        self.items.removeAll()
       
        updateUI(with: sortedItems)
        sortButton.setTitle("Popular", for: .normal)
    }
    
    
    @objc func sortByDate() {
        let activeItems = isFiltered ? filteredItems : items
        sortedItems = activeItems.sorted { $0.attributes.releasedAt.convertToDate()!.convertToInt() > $1.attributes.releasedAt.convertToDate()!.convertToInt() }
        self.items.removeAll()
        
        updateUI(with: sortedItems)
        sortButton.setTitle("Newest", for: .normal)
    }
    
    func fetchContent() {
        showLoadingView()
        
        NetworkManager.shared.getArticles { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let articles):
                self.fetchedItems.append(contentsOf: articles.data)
                self.updateUI(with: articles.data)

                NetworkManager.shared.getVideos { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let videos):
                        self.fetchedItems.append(contentsOf: videos.data)
                        self.updateUI(with: videos.data)
                    case .failure(let error):
                        DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
    
    func getDownloads() {
        PersistenceManager.retreiveItems(for: Keys.downloads) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloads):
                for download in downloads {
                    if !self.downloadedItems.contains(download) {
                        self.downloadedItems.append(download)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error", message: error.rawValue, in: self) }
            }
        }
    }
    
    func getBookmarks() {
        PersistenceManager.retreiveItems(for: Keys.bookmarks) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let bookmarks):
                for bookmark in bookmarks {
                    if !self.bookmarkedItems.contains(bookmark) {
                        self.bookmarkedItems.append(bookmark)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { UIHelper.createAlertController(title: "Error!", message: error.rawValue, in: self) }
            }
        }
    }
}

extension LibraryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeItems = isSearching ? filteredItems : items
        let item = activeItems[indexPath.item]
        
        var savedItem = Item(id: item.id, type: item.type, attributes: item.attributes, isDownloaded: false, isBookmarked: false)
        
        for downloadedItem in downloadedItems {
            for bookmarkedItem in bookmarkedItems {
                if (bookmarkedItem.id == savedItem.id) && (downloadedItem.id == savedItem.id) {
                    savedItem = Item(id: item.id, type: item.type, attributes: item.attributes, isDownloaded: true, isBookmarked: true)
                    break
                } else if downloadedItem.id == savedItem.id {
                    savedItem = Item(id: item.id, type: item.type, attributes: item.attributes, isDownloaded: true, isBookmarked: false)
                } else if bookmarkedItem.id == savedItem.id {
                    savedItem = Item(id: item.id, type: item.type, attributes: item.attributes, isDownloaded: false, isBookmarked: true)
                }
            }
        }
            
        let destVC = ItemDetailVC(with: savedItem)
        
      if SceneDelegate.windowInterfaceOrientation!.isPortrait {
        navigationController?.pushViewController(destVC, animated: true)
      } else {
        delegate.didPassItem(item: savedItem)
      }
    }
}

extension LibraryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 170
        
        return CGSize(width: width, height: height)
    }
}

extension LibraryVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        var activeItems: [Item] = []
        sortButton.isHidden = true
        sortButton.isUserInteractionEnabled = false
        
        if isFiltered {
            activeItems = filteredItems
        } else if isSorted {
            activeItems = sortedItems
        } else {
            activeItems = items
        }
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            activeItems.removeAll()
            updateData(with: items)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredItems = activeItems.filter { $0.attributes.name.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredItems)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.sortButton.isHidden = false
            self.sortButton.isUserInteractionEnabled = true
        }
    }
}

extension LibraryVC: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let destVC = FiltersVC()
        destVC.title = "Filters"
        destVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension LibraryVC: FiltersVCDelegate {
    func updateUI(with filter: String) {
        
        if filter == "All" {
            items.removeAll()
            fetchContent()
            contentLabel.text = "All"
            isFiltered = false
            return
        } else {
            filteredItems.removeAll()
            items.removeAll()
            items = fetchedItems
        
            for item in items {
                if item.attributes.contentType == filter.lowercased() {
                    filteredItems.append(item)
                }
            }
            contentLabel.text = filter
            isFiltered = true
            updateData(with: filteredItems)
        }
    }
}
