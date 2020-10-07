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

  private var tutorials: [Tutorial] = []
  private var videos: [Tutorial] = []
  private var articles: [Tutorial] = []

  private let cache = Cache<String, Data>()
  private let photoFetchQueue = OperationQueue()
  private var operations = [String: Operation]()


  @IBOutlet weak var collectionView: UICollectionView!


  @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      networkingController.fetchTutorials(ofType: .article) {  (result) in
        let result = try! result.get()
        //      print(result.count)
        self.articles = result
        self.tutorials = result
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    case 1:
      networkingController.fetchTutorials(ofType: .video) {  (result) in
        let result = try! result.get()
        //      print(result.count)

        self.videos = result
        self.tutorials = result
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    default:
      networkingController.fetchTutorials(ofType: .video) {  (result) in
        let result = try! result.get()
        //      print(result.count)
        self.videos = result
        self.tutorials = result + self.articles
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    
    networkingController.fetchTutorials(ofType: .article) {  (result) in
      let result = try! result.get()
      //      print(result.count)
      self.tutorials = result
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tutorials.count
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCell", for: indexPath) as! TutorialCell
    let article = tutorials[indexPath.row]
    cell.descriptionLabel.text = article.attributes.description

    cell.releaseDate.text = "Release Date: \(article.attributes.releaseDate.toString())"
    print(article.attributes.releaseDateString)
    cell.nameLabel.text = article.attributes.name

    loadImage(forCell: cell, forItemAt: indexPath)

    return cell
  }
  private func loadImage(forCell cell: TutorialCell, forItemAt indexPath: IndexPath) {
    let tutorial = tutorials[indexPath.item]

    // Check for image in cache
    if let cachedImageData = cache.value(for: tutorial.attributes.name),
       let image = UIImage(data: cachedImageData) {
      cell.artworkImageView.image = image
      return
    }

    // Start an operation to fetch image data
    let fetchOp = FetchPhotoOperation(photoReference: tutorial)
    
    let cacheOp = BlockOperation {
      if let data = fetchOp.imageData {
        self.cache.cache(value: data, for: tutorial.attributes.name)
      }
    }
    let completionOp = BlockOperation {
      defer { self.operations.removeValue(forKey: tutorial.attributes.name) }

      if let currentIndexPath = self.collectionView?.indexPath(for: cell),
         currentIndexPath != indexPath {
        print("Got image for now-reused cell")
        return // Cell has been reused
      }

      if let data = fetchOp.imageData {
        cell.artworkImageView.image = UIImage(data: data)
      }
    }

    cacheOp.addDependency(fetchOp)
    completionOp.addDependency(fetchOp)

    photoFetchQueue.addOperation(fetchOp)
    photoFetchQueue.addOperation(cacheOp)
    OperationQueue.main.addOperation(completionOp)

    operations[tutorial.attributes.name] = fetchOp
  }
}
