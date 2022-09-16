//
//  UIImageExtensions.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/15/22.
//

import Foundation
import UIKit
import OSLog

// We want to have a cache of images to optimize performance and reduce unnecessary network calls
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    /// Loads an image from a url and saves it in cache
    /// If the image is already in cache it returns it directly, otherwise fetches it from network
    /// - Parameter url: the url of the image
    func load(fromURL urlStr: String) {
        // Check if image is in cache and retrieve it
        if let cachedImage = imageCache.object(forKey: urlStr as NSString) {
            image = cachedImage
            return
        }
        
        // Otherwise fetch from network
        if let url = URL(string: urlStr) {
            let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                guard let self = self else { return }
                if let error = error {
                    Logger.networking.error("Failed to retrieve image from url \(urlStr) with error \(error)")
                    return
                }
                
                guard let data = data else {
                    Logger.networking.error("Failed to retrieve image from url \(urlStr). Request came back with no data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            dataTask.resume()
        }
    }
}
