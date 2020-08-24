//
//  Attributes.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/19/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
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
