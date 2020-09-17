//
//  NetworkManager.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/20/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation
import UIKit

class CourseAPIService {
  static let shared = CourseAPIService()
  static let artworkCache = NSCache<NSString, UIImage>()
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return formatter
  }()

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  func fetchContent(for url: String, completion: @escaping (Result<Results, CourseAPIServiceError>) -> Void) {
    guard let videosEndPointURL = URL(string: url) else { return }

    URLSession.shared.dataTask(with: videosEndPointURL) { data, _, error in
      guard let data = data, error == nil else {
        if error != nil {
          completion(.failure(.domainError))
        }
        return
      }

      do {
        self.decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
        let results = try self.decoder.decode(Results.self, from: data)
        completion(.success(results))
      } catch {
        print("Decoding Error: \(error)")
        completion(.failure(.decodingError))
      }
    }
    .resume()
  }

  func fetchCardArtwork(for artworkUrl: URL, completion: @escaping(Result<UIImage, CourseAPIServiceError>) -> Void) {
    if let cachedArtwork = CourseAPIService.artworkCache.object(forKey: NSString(string: artworkUrl.absoluteString)) {
      //use cached artwork image
      completion(.success(cachedArtwork))
    } else {
      //create a new artwork image
      URLSession.shared.dataTask(with: artworkUrl) { data, _, error in
        if error != nil {
          completion(.failure(.apiError))
          return
        }

        guard let data = data else {
          completion(.failure(.noData))
          return
        }

        guard let artwork = UIImage(data: data) else {
          completion(.failure(.imageDataError))
          return
        }
        CourseAPIService.artworkCache.setObject(artwork, forKey: NSString(string: artworkUrl.absoluteString))
        completion(.success(artwork))
      }
    .resume()
    }
  }
}
