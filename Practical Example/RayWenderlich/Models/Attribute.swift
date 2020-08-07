//
//  Video.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import Foundation

struct Attribute: Codable, Hashable {
    var uri: String
    var name: String
    var description: String
    var releasedAt: String
    var free: Bool
    var difficulty: String?
    var contentType: String
    var duration: Int
    var popularity: Double
    var technologyTripleString: String
    var contributorString: String
    var professional: Bool
    var descriptionPlainText: String
    var cardArtworkUrl: String
}
