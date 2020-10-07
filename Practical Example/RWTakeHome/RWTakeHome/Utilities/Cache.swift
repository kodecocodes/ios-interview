//
//  Cache.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

class Cache<Key: Hashable, Value> {
  
  func cache(value: Value, for key: Key) {
    queue.async {
      self.cache[key] = value
    }
  }

  func value(for key: Key) -> Value? {
    return queue.sync {
      cache[key]
    }
  }

  private var cache = [Key: Value]()
  private let queue = DispatchQueue(label: "com.nicknguyen.RWTakeHome.CacheQueue")
}
