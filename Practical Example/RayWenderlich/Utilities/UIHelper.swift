//
//  UIHelper.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

struct UIHelper {
    
    static func createCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    static func createAlertController(title: String, message: String, in viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(ac, animated: true)
    }
    
    static func createActivityController(for item: Item, collectionView: UICollectionView, indexPath: IndexPath, for viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: [item.attributes.uri], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = collectionView.cellForItem(at: indexPath)
        activityViewController.isModalInPresentation = true
        viewController.present(activityViewController, animated: true)
    }
}
