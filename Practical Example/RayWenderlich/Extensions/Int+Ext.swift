//
//  Int+Ext.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import Foundation

extension Int {
    
    func convertToDuration() -> String {
        if self < 60 {
            return "(\(self) mins)"
        } else {
            if self % 60 == 0 {
                return "(\(self / 60) hrs)"
            } else {
                return "(\(self / 60) hrs, \(self % 60) mins)"
            }
        }
    }
}
