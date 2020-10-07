//
//  ViewController.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

class TutorialViewController: UIViewController {

  //MARK:- Properties

  let networkService = NetworkService()
  var tutorials: [Tutorial] = []
  var videos: [Tutorial] = []
  var articles: [Tutorial] = []
  private let cache = Cache<String, Data>()
  private let photoFetchQueue = OperationQueue()
  private var operations = [String: Operation]()

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet { collectionView.dataSource = self }
  }

  //MARK:- IBActions
  @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
    case 0: // Article

      self.tutorials = self.articles.sorted(by: <)

      self.reloadDataOnMainThread()

    case 1: // Video

      self.tutorials = self.videos.sorted(by: <)

      self.reloadDataOnMainThread()

    default: // All

      self.tutorials = self.videos.sorted(by: <) + self.articles.sorted(by: <)
      
      self.reloadDataOnMainThread()
    }
  }
  //MARK:- View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    getArticles()
    getVideos()

  }
}
//MARK:- UICollection Datasource & Delegate
extension TutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tutorials.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCell", for: indexPath) as! TutorialCell

    let article = self.tutorials[indexPath.row]

    cell.descriptionLabel.text = article.attributes.description

    cell.releaseDate.text = "Release Date: \(article.attributes.releaseDate.toString())"

    cell.nameLabel.text = article.attributes.name

    cell.typeLabel.text = article.attributes.contentType == "collection" ? "Video" : article.attributes.contentType.capitalized

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
    let fetchOp = FetchPhotoOperation(tutorial: tutorial)
    
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
        return
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
