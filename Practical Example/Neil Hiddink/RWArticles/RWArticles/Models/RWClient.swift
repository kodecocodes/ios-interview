//
//  RWClient.swift
//  RWArticles
//
//  Created by Neil Hiddink on 8/17/20.
//  Copyright © 2020 Neil Hiddink. All rights reserved.
//

import Foundation

class RWClient {
    
    private final let ARTICLES_URL = "https://api.jsonbin.io/b/5ed679357741ef56a566a67f"
    private final let VIDEOS_URL = "https://api.jsonbin.io/b/5ed67c667741ef56a566a831"
    
    static let shared = RWClient()
    
    func getArticleDataAsJSON() -> [RWArticle] {
        guard let url = URL(string: ARTICLES_URL) else { fatalError("Url is invalid.") }
        let data = URLSession.shared.downloadTask(with: url) { (url, response, error) in
            if let error = error { print(error.localizedDescription) }
            
            print(response)
        }
        
        return []
    }
    
    func getVideoDataAsJSONFrom(url: URL) -> [RWVideo] {
        guard let url = URL(string: VIDEOS_URL) else { fatalError("Url is invalid.") }
        let request = URLRequest(url: url)
        
        return []
    }
}

/*
Keep your files short and sweet, use extensions and break out helpers when appropriate.
Make sure the main functionality of the app is tested (or at least testable).
It's important that the app follows a clear architecture pattern.
Comment and document your code where appropriate.
Feel free to use 3rd party libraries, but make sure to justify why you've used them in the README.
Be consistent with your coding style. Feel free to adhere to the raywenderlich.com swift style guide.
Remove any unused or Apple-generated code

Fetch articles and video courses and display them once both networking calls have finished.
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
