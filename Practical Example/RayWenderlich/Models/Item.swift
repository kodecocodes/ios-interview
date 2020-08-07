//
//  Article.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import Foundation

struct Item: Codable, Hashable {
    var id: String
    var type: String
    var attributes: Attribute
    
    var isDownloaded: Bool?
    var isBookmarked: Bool?
    var isInProgress: Bool?
    var isCompleted: Bool?
}

struct SavedItem: Codable, Hashable {
    var id: String
    var type: String
    var attributes: Attribute
    
    var isDownloaded: Bool = false
    var isBookmarked: Bool = false
}
