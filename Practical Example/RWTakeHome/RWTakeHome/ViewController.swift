//
//  ViewController.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

//https://api.jsonbin.io/b/5f7da8e57243cd7e824c263f // video
//https://api.jsonbin.io/b/5f7da6f065b18913fc5bfe74 // article


class ViewController: UIViewController {

  let networkingController = Networking()

  override func viewDidLoad() {
    super.viewDidLoad()
    networkingController.fetchTutorials(ofType: .article) { (result) in
      let result = try! result.get()
      print(result)
    }
  }


}

