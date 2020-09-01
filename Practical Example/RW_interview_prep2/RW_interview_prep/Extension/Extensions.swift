//
//  Extensions.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/25/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

extension Date {
   
   func convertToMonthDayYearFormat() -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "MMM dd yyyy"
       
       return formatter.string(from: self)
   }
   
   func convertToInt() -> Int {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyMMdd"
       
       return Int(formatter.string(from: self))!
   }
}

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
