//
//  RWItemsVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWItemsVC: UIViewController {
    
    var collectionView: UICollectionView!
    
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        
    }
    
    func configureViewController() {
        
        view.backgroundColor = .secondarySystemBackground
        
        
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
        
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    
    
}

extension RWItemsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
