//
//  Tutorial.swift
//  RW Take Home
//
//  Created by Zoha on 7/28/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

struct Tutorial: Codable, Hashable, Equatable {
  static func == (lhs: Tutorial, rhs: Tutorial) -> Bool {
    return lhs.id == rhs.id
  }
  
  let id, type: String
  let attributes: Attributes
}
