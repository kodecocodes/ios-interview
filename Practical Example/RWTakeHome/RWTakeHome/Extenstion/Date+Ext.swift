//
//  Date+Ext.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

extension Date {
  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.calendar = .current
    return formatter.string(from: self)
  }
}
