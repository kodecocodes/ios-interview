//
//  RWMainVC.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-07.
//

import UIKit

class RWMainVC: UIViewController {
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    var tabBarView = UIView()
    var splitView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureViewController()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        coordinator.animate(alongsideTransition: { (context) in
            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }

            if windowInterfaceOrientation.isLandscape {
                self.splitView.isHidden = false
                self.view.addSubview(self.splitView)
                self.splitView.translatesAutoresizingMaskIntoConstraints = false
                self.splitView.pinToEdges(of: self.view)
                
                self.add(childVC: RWSplitViewController(style: .doubleColumn), to: self.splitView)
                
                self.tabBarView.isHidden = true
                        
            } else {
                self.tabBarView.isHidden = false
                self.view.addSubview(self.tabBarView)
                self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
                self.tabBarView.pinToEdges(of: self.view)
                
                self.self.add(childVC: RWTabBarController(), to: self.tabBarView)
                
                self.splitView.isHidden = true
                    
            }
        })
    }
    
    func configureViewController() {
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.pinToEdges(of: view)
        
        self.add(childVC: RWTabBarController(), to: self.tabBarView)
        
        splitView.isHidden = true
    }
}
