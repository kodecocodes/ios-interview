//
//  FetchRequest.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/25/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

class NetworkFetchRequest: ObservableObject {
    
    @Published var AllData = [ArticleAndVideoData]()
    @Published var videoData = [ArticleAndVideoData]()
    
    
    init() {
        fetchArticleData()
        fetchVideoData()
    }

    func fetchArticleData() {

        if let url = URL(string: "https://api.jsonbin.io/b/5ed679357741ef56a566a67f") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Arcdata.self, from: safeData)

                            DispatchQueue.main.async {
                                self.AllData.append(contentsOf: results.data)
                            }
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func fetchVideoData() {
        if let url = URL(string:"https://api.jsonbin.io/b/5ed67c667741ef56a566a831") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respnse, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Arcdata.self, from: safeData)
                            DispatchQueue.main.async {
                                self.AllData.append(contentsOf: results.data)
                                self.videoData = results.data
                            }
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
}
