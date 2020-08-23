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
        
    func getArticleContentAsJSON(_ completion: @escaping ([RWContent], String?) -> Void) {
        guard let articleURL = URL(string: ARTICLES_URL) else { return }
        let session = URLSession.shared.dataTask(with: articleURL) { (data, response, error) in
            guard let data = data else { if let error = error { print(error.localizedDescription) }; return }
            
            assert((response as? HTTPURLResponse) != nil)
            assert((response as! HTTPURLResponse).statusCode == 200)
            
            let decoder = JSONDecoder()
            
            do { // https://stackoverflow.com/a/53231548
                let rwResponse = try decoder.decode(RWResponse.self, from: data)
                completion(rwResponse.data, nil)
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
    
    func getVideoContentAsJSON(_ completion: @escaping ([RWContent], String?) -> Void) {
        guard let videoURL = URL(string: VIDEOS_URL) else { return }
        let session = URLSession.shared.dataTask(with: videoURL) { (data, response, error) in
            guard let data = data else { if let error = error { print(error.localizedDescription) }; return }
            
            assert((response as? HTTPURLResponse) != nil)
            assert((response as! HTTPURLResponse).statusCode == 200)
            
            let decoder = JSONDecoder()
            
            do { // https://stackoverflow.com/a/53231548
                let rwResponse = try decoder.decode(RWResponse.self, from: data)
                completion(rwResponse.data, nil)
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
