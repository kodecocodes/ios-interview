//
//  Item.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/19/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct Item: Codable, Hashable {
  let identifier = UUID()
  let type: String
  let attributes: Attribute
  let links: Link?

  enum CodingKeys: CodingKey {
    case type
    case attributes
    case links
  }

  static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}
