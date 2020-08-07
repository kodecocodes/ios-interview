//
//  NetworkManager.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let session = URLSession.shared
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getArticles(completed: @escaping (Result<Results, RWError>) -> Void) {
        guard let url = URL(string: EndPoints.articlesURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let articles = try decoder.decode(Results.self, from: data)
                completed(.success(articles))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
    
    func getVideos(completed: @escaping (Result<Results, RWError>) -> Void) {
        guard let url = URL(string: EndPoints.videosURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let articles = try decoder.decode(Results.self, from: data)
                completed(.success(articles))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
}
