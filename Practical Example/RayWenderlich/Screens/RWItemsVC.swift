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
    
    weak var delegate: RWItemsVCDelegate!
    
    var collectionView: UICollectionView!
    
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        
    }
    
    func configureViewController() {
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        title = "raywenderlich.com"
        
        items.append("Library")
        items.append("Downloads")
        items.append("My Tutorials")
    }
    
    func configureCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)
        collectionView.backgroundColor = .secondarySystemBackground
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension RWItemsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = items[indexPath.row]
        
        if indexPath.row == 0 {
            contentConfiguration.image = Images.library
        } else if indexPath.row == 1 {
            contentConfiguration.image = Images.downloads
        } else {
            contentConfiguration.image = Images.person
        }
        
        cell.contentConfiguration = contentConfiguration
        cell.backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        cell.tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
        
        return cell
    }
    
    
}

extension RWItemsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVCTitle = items[indexPath.item]
        print(destVCTitle)
        delegate.didSelectVC(with: destVCTitle)
    }
}
