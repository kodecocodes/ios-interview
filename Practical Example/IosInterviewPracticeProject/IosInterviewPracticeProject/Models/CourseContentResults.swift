//
//  ItemContentResults.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 9/28/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct CourseContentResults: Codable, Hashable {
  let data: Item
  let included: [IncludedAttributes]?
}
