//
//  HTTPURLResponse+Ext.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

extension HTTPURLResponse {
  var isOK: Bool {
    return statusCode == 200
  }
}

