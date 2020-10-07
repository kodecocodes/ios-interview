//
//  Tutorial.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

enum TutorialType: String, Decodable {
  case article
  case video
}

struct Tutorial: Decodable {

  let attributes: Attributes
}

struct DataTutorial: Decodable {
  let tutorials: [Tutorial]

  enum CodingKeys: String, CodingKey {
    case tutorials = "data"
  }
}

struct Attributes: Decodable {

  let name: String
  let artwork: URL
  let description: String
  let releaseDate: String


  enum CodingKeys: String, CodingKey {
    case name = "name"
    case artwork = "card_artwork_url"
    case description = "description_plain_text"
    case releaseDate = "released_at"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let name = try container.decode(String.self, forKey: .name)
    let artworkString = try container.decode(String.self, forKey: .artwork)
    let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
    let description = try container.decode(String.self, forKey: .description)

    self.name = name
    self.description = description
    self.artwork = URL(string: artworkString)!
    self.releaseDate = releaseDateString

  }
}


