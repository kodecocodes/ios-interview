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
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = .current

    let formattedDate = dateFormatter.string(from: self)

    return formattedDate
  }
}
