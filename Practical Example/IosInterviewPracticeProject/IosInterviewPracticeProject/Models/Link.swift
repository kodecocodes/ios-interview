//
//  Link.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 9/6/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct Link: Codable {
  var current: String?
  var first: String?
  var previous: String?
  var next: String?
  var last: String?

  enum CodingKeys: String, CodingKey {
    case current = "self"
    case first
    case previous = "prev"
    case next
    case last
  }
}
