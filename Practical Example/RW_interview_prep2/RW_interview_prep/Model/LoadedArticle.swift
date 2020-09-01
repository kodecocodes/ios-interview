//
//  LoadedArticle.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/28/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

import SwiftUI
import CoreData

class Article {
    
    
    static func loadDataFromJSON(completion: @escaping (Arcdata) -> ()) {
        
        if let url = URL(string: "https://api.jsonbin.io/b/5ed679357741ef56a566a67f") {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if error == nil {
                            let decoder = JSONDecoder()
                            if let safeData = data {
                                do {
                                    let results = try decoder.decode(Arcdata.self, from: safeData)
                                    completion(results)
                                } catch {
                                    print("error: ", error)
                                }
                            }
                        }
                    }
                    task.resume()
                }
    }
    
    
    
    static func loadDataToCD(moc: NSManagedObjectContext) {
        loadDataFromJSON { (articles) in
            DispatchQueue.main.async {
                
                var tempArticles = [AttributeArticle]()
                for article in articles.data {
                    
                    let newArticle = AttributeArticle(context: moc)
                    newArticle.name = article.attributes.name
                    newArticle.card_artwork_url = article.attributes.card_artwork_url
                    newArticle.content_type = article.attributes.content_type
                    newArticle.contributor_string = article.attributes.contributor_string
                    newArticle.description_plain_text = article.attributes.description_plain_text
                    newArticle.descriptionn = article.attributes.description
                    newArticle.difficulty = article.attributes.difficulty
                    newArticle.duration = article.attributes.duration ?? 0
                    newArticle.free = article.attributes.free
                    newArticle.popularity = Int16(article.attributes.popularity ?? 0)
                    newArticle.released_at = article.attributes.released_at
                    newArticle.technology_triple_string = article.attributes.technology_triple_string
                    tempArticles.append(newArticle)
                }
                do {
                    try moc.save()
                } catch let error {
                    print("Could not save data: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
