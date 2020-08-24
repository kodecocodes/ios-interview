//
//  Item.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/19/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

struct Item: Codable, Hashable {
  var id: String
    var type: String
    var attributes: Attribute
}
