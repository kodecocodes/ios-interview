//
//  Date+Ext.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
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
