//
//  Course.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/16/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct Results: Codable, Hashable {
  let data: [Item]
  let included: [IncludedAttributes]?
}
