//
//  SceneDelegate.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
//        if windowScene.interfaceOrientation.isPortrait {
            window?.rootViewController = RWTabBarController()
//        } else if windowScene.interfaceOrientation.isLandscape {
//        window?.rootViewController = RWSplitViewController(style: .doubleColumn)
//        }
        
        window?.makeKeyAndVisible()
        
        configureNavBar()
    }
    
    func configureNavBar() {
        UINavigationBar.appearance().tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
    }
}

