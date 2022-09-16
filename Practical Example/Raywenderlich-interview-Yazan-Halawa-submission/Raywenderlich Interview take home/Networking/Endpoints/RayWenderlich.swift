//
//  Articles.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import Foundation

enum RayWenderlich: Endpoint {
    case articles
    case videos
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "raw.githubusercontent.com"
    }
    
    var path: String {
        switch self {
        case .articles:
            return "/raywenderlich/ios-interview/master/Practical Example/articles.json"
        case .videos:
            return "/raywenderlich/ios-interview/master/Practical Example/videos.json"
        }
    }
    
    var queryParameters: [URLQueryItem] {
        return []
    }
}
