//
//  RWClient.swift
//  RWContent
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import Foundation

class RWClient {
    
    private final let ARTICLES_URL = "https://api.jsonbin.io/b/5ed679357741ef56a566a67f"
    private final let VIDEOS_URL = "https://api.jsonbin.io/b/5ed67c667741ef56a566a831"
    
    static let shared = RWClient()
    
    func getArticleDataAsJSON(_ completion: @escaping ([RWArticle], Error?) -> Void) {
        guard let url = URL(string: ARTICLES_URL) else { fatalError("Url is invalid.") }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { if let error = error { print(error.localizedDescription) }; return }
            
            assert((response as? HTTPURLResponse) != nil)
            assert((response as! HTTPURLResponse).statusCode == 200)
            
            let decoder = JSONDecoder()
            
            do { // https://stackoverflow.com/a/53231548
                let responseData = try decoder.decode(RWResponse.self, from: data)
                completion(responseData.data, nil)
            } catch let DecodingError.dataCorrupted(context) { // TODO: Refactor this into an error handling object
                debugPrint(context)
            } catch let DecodingError.keyNotFound(key, context) {
                debugPrint("Key '\(key)' not found:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                debugPrint("Value '\(value)' not found:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                debugPrint("Type '\(type)' mismatch:", context.debugDescription)
                debugPrint("codingPath:", context.codingPath)
            } catch {
                debugPrint("error: ", error)
            }
        }
        
        session.resume()
    }
}

/*
Keep your files short and sweet, use extensions and break out helpers when appropriate.

Make sure the main functionality of the app is tested (or at least testable).

For each item (article or video course) you have to display at least:
Name
Artwork
Description
Type (article or video)

The results should be sorted by release date.

There should be a way to view:
Only articles
Only videos
Both
*/
