//
//  Date+Formatting.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 10/10/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

extension Date {
  func formatDateString() -> String {
    let iso8601DateFormatter = ISO8601DateFormatter()
    iso8601DateFormatter.formatOptions = .withFullDate

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none

    guard let isoDate = iso8601DateFormatter.date(from: self.description) else { return self.description }

    let formattedDate = dateFormatter.string(from: isoDate)

    return formattedDate
  }
}
