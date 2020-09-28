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
  }
