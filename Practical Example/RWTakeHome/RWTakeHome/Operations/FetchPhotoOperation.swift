//
//  FetchPhotoOperation.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {

  // MARK: Properties

  let tutorial: Tutorial
  private let session: URLSession
  private(set) var imageData: Data?
  private var dataTask: URLSessionDataTask?


  init(tutorial: Tutorial, session: URLSession = URLSession.shared) {
    self.tutorial = tutorial
    self.session = session
    super.init()
  }

  override func start() {
    state = .isExecuting
    let url = tutorial.attributes.artwork

    let task = session.dataTask(with: url) { (data, response, error) in
      defer { self.state = .isFinished }
      if self.isCancelled { return }
      if let error = error {
        NSLog("Error fetching data for \(self.tutorial): \(error)")
        return
      }

      self.imageData = data
    }
    task.resume()
    dataTask = task
  }

  override func cancel() {
    dataTask?.cancel()
    super.cancel()
  }
}
