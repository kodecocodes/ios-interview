//
//  CocurrentOperation.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//


import Foundation

class ConcurrentOperation: Operation {

  // MARK: Types

  enum State: String {
    case isReady, isExecuting, isFinished
  }

  // MARK: Properties

  private var _state = State.isReady

  private let stateQueue = DispatchQueue(label: "com.nicknguyen.RW TakeHome.ConcurrentOperationStateQueue")
  
  var state: State {
    get {
      var result: State?
      let queue = self.stateQueue
      queue.sync {
        result = _state
      }
      return result!
    }

    set {
      let oldValue = state
      willChangeValue(forKey: newValue.rawValue)
      willChangeValue(forKey: oldValue.rawValue)

      stateQueue.sync { self._state = newValue }

      didChangeValue(forKey: oldValue.rawValue)
      didChangeValue(forKey: newValue.rawValue)
    }
  }

  // MARK: NSOperation

  override dynamic var isReady: Bool {
    return super.isReady && state == .isReady
  }

  override dynamic var isExecuting: Bool {
    return state == .isExecuting
  }

  override dynamic var isFinished: Bool {
    return state == .isFinished
  }

  override var isAsynchronous: Bool {
    return true
  }
}
