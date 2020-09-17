//
//  Included.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 9/12/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct Included: Codable, Hashable {
  var id: String?
  var type: String?
  var attributes: [IncludedAttributes]?
}
