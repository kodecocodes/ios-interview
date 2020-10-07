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

  var attributes: Attributes
}

struct DataTutorial: Decodable {
  let tutorials: [Tutorial]

  enum CodingKeys: String, CodingKey {
    case tutorials = "data"
  }
}

struct Attributes {
  
  let name: String
  let artwork: URL
  let description: String
  let releaseDateString: String
  let contentType: String

  var releaseDate: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFormatter.date(from: releaseDateString) ?? Date()
  }

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case artwork = "card_artwork_url"
    case description = "description_plain_text"
    case releaseDate = "released_at"
    case contentType = "content_type"
  }
}

extension Attributes: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let name = try container.decode(String.self, forKey: .name)
    let artworkString = try container.decode(String.self, forKey: .artwork)
    let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
    let description = try container.decode(String.self, forKey: .description)
    let contentType = try container.decode(String.self, forKey: .contentType)

    self.name = name
    self.description = description
    self.artwork = URL(string: artworkString)!
    self.releaseDateString = releaseDateString
    self.contentType = contentType
  }
}


extension Tutorial: Comparable {
  static func == (lhs: Tutorial, rhs: Tutorial) -> Bool {
    return lhs.attributes.releaseDate == rhs.attributes.releaseDate
  }

  static func < (lhs: Tutorial, rhs: Tutorial) -> Bool {
    return lhs.attributes.releaseDate < rhs.attributes.releaseDate
  }
}
