//
//  String+Ext.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [
        .withInternetDateTime,
        .withDashSeparatorInDate,
        .withFullDate,
        .withFractionalSeconds,
        .withColonSeparatorInTimeZone
      ]
        
        return formatter.date(from: self)
    }
    
    func converToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        
        return date.convertToMonthDayYearFormat()
    }
}
