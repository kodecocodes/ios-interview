//
//  Attributes.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/19/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation
struct Attribute: Codable, Hashable {
  let uri: String
  let name: String
  let description: String
  let releasedAt: Date
  let free: Bool
  let difficulty: String?
  let contentType: String
  let duration: Int
  let popularity: Double
  let technologyTripleString: String
  let contributorString: String
  let professional: Bool
  let descriptionPlainText: String
  let cardArtworkUrl: String
  let body: String?

  //swiftlint:disable redundant_string_enum_value
  enum CodingKeys: String, CodingKey {
    case uri = "uri"
    case name = "name"
    case description = "description"
    case releasedAt = "releasedAt"
    case free = "free"
    case difficulty = "difficulty"
    case contentType = "contentType"
    case duration = "duration"
    case popularity = "popularity"
    case technologyTripleString = "technologyTripleString"
    case contributorString = "contributorString"
    case professional = "professional"
    case descriptionPlainText = "descriptionPlainText"
    case cardArtworkUrl = "cardArtworkUrl"
    case body = "body"
    }

    init(from decoder: Decoder ) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      uri = try container.decode(String.self, forKey: .uri)
      name = try container.decode(String.self, forKey: .name)
      description = try container.decode(String.self, forKey: .description)
      releasedAt = try container.decode(Date.self, forKey: .releasedAt)
      free = try container.decode(Bool.self, forKey: .free)
      difficulty = try container.decode(String.self, forKey: .difficulty)
      contentType = try container.decode(String.self, forKey: .contentType)
      duration = try container.decode(Int.self, forKey: .duration)
      popularity = try container.decode(Double.self, forKey: .popularity)
      technologyTripleString = try container.decode(String.self, forKey: .technologyTripleString)
      contributorString = try container.decode(String.self, forKey: .contributorString)
      professional = try container.decode(Bool.self, forKey: .professional)
      descriptionPlainText = try container.decode(String.self, forKey: .descriptionPlainText)
      cardArtworkUrl = try container.decode(String.self, forKey: .cardArtworkUrl)
      body = try container.decode(String.self, forKey: .body)
    }
  }
