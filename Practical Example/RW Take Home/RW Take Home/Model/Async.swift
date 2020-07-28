//
//  Async.swift
//  RW Take Home
//
//  Created by Zoha on 7/28/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import Foundation

enum Async<Success> {
  case unInitialized
  case loading
  case success(Success)
  case failure(Error)
}
