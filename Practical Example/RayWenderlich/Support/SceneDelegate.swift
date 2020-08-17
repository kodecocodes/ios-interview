//
//  SceneDelegate.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  static var windowInterfaceOrientation: UIInterfaceOrientation? {
    return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
  }
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = RWMainVC()
    
    window?.makeKeyAndVisible()
    
    configureNavBar()
  }
  
  func configureNavBar() {
    UINavigationBar.appearance().tintColor = UIColor(hue:0.365, saturation:0.527, brightness:0.506, alpha:1)
  }
}

