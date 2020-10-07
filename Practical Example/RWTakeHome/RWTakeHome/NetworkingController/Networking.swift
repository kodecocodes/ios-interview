//
//  Networking.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

class Networking {

  let jsonDecoder = JSONDecoder()

  private var SECRET_KEY: String {
    let env = ProcessInfo.processInfo.environment
    return env["SecretKey"] ?? "NO KEY"
  }

  private func generateURLForTutorial(ofType type: TutorialType) -> URLRequest {
    switch type {
    case .article:
      let articleURL = URL(string: "https://api.jsonbin.io/b/5f7da6f065b18913fc5bfe74")!
      return URLRequest(url: articleURL)
    case .video:
      let videoUrl = URL(string: "https://api.jsonbin.io/b/5f7da8e57243cd7e824c263f")!
      return URLRequest(url: videoUrl)
    }
  }


  func fetchTutorials(ofType type: TutorialType, completion: @escaping (Result<[Tutorial],Error>) -> Void) {

    var urlRequest = generateURLForTutorial(ofType: type)
    urlRequest.setValue(SECRET_KEY, forHTTPHeaderField: "secret-key")

    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in


      if let error = error {
        completion(.failure(error))
        print(error.localizedDescription)
      }

      guard let response = response as? HTTPURLResponse, response.isOK else {
        fatalError("Response is not 200")
      }

      guard let data = data else {
        return
      }
      
      do {

        let tutorials = try self.jsonDecoder.decode(DataTutorial.self, from: data)
       
        completion(.success(tutorials.tutorials))
      } catch {
        print(error.localizedDescription)
      }
    }.resume()
  }
 
}

