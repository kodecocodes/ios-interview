//
//  TutorialViewModel.swift
//  RW Take Home
//
//  Created by Zoha on 7/28/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation
import Combine

class TutorialViewModel {
  @Published private(set) var tutorials: Async<[Tutorial]> = .unInitialized
  let tutorialTypeKey = "TutorialType"
  var selectedTutorialType: TutorialType {
    didSet {
      updateTutorials()
      UserDefaults.standard.set(selectedTutorialType.rawValue, forKey: tutorialTypeKey)
    }
  }

  private var cancellables: Set<AnyCancellable> = []

  private var videoTutorials: [Tutorial] = []
  private var articleTutorials: [Tutorial] = []

  init() {
    if let tutorialTypeTxt = UserDefaults.standard.string(forKey: tutorialTypeKey),
      let tutorialType = TutorialType.init(rawValue: tutorialTypeTxt) {
      self.selectedTutorialType = tutorialType
    } else {
      selectedTutorialType = .both
    }
  }

  func fetchTutorial() {
    tutorials = .loading

    let dateFormatter = DateFormatter()
    let decoder = JSONDecoder()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    guard let videoURL = URL(string: "https://api.jsonbin.io/b/5ed67c667741ef56a566a831") else {
      tutorials = .failure(URLError(.badURL))
      return
    }
    let videoPublisher = URLSession.shared.dataTaskPublisher(for: videoURL)
      .map(\.data)
      .decode(type: APIResult.self, decoder: decoder)

    guard let articleURL = URL(string: "https://api.jsonbin.io/b/5ed679357741ef56a566a67f") else {
      tutorials = .failure(URLError(.badURL))
      return
    }
    let articlePublisher = URLSession.shared.dataTaskPublisher(for: articleURL)
      .map(\.data)
      .decode(type: APIResult.self, decoder: decoder)

    Publishers.Zip(videoPublisher, articlePublisher)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          DispatchQueue.main.async {
            self.tutorials = .failure(error)
          }
        case .finished:
          return
        }
      }, receiveValue: { videoResult, articleResult in
        self.videoTutorials = videoResult.data
        self.articleTutorials = articleResult.data

        self.updateTutorials()
      })
      .store(in: &cancellables)
  }

  private func updateTutorials() {
    guard !videoTutorials.isEmpty && !articleTutorials.isEmpty else {
      return
    }

    var tutorials: [Tutorial]

    switch selectedTutorialType {
    case .article:
      tutorials = articleTutorials
    case .video:
      tutorials = videoTutorials
    case .both:
      tutorials = videoTutorials + articleTutorials
    }

    tutorials.sort {
      $0.attributes.releasedAt > $1.attributes.releasedAt
    }

    DispatchQueue.main.async {
      self.tutorials = .success(tutorials)
    }
  }
}
