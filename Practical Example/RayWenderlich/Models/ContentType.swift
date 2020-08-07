//
//  ContentType.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-03.
//

import Foundation

struct ContentType: Codable, Hashable {
    var type: String
    var isSelected: Bool
}

struct SelectedRow: Codable, Hashable {
    var type: ContentType
    var indexPath: IndexPath
}
