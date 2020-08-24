//
//  CourseAPIServiceError.swift
//  IosInterviewPracticeProject
//
//  Created by Robert Ramirez on 8/23/20.
//  Copyright © 2020 me.robert.ramirez. All rights reserved.
//

import Foundation

public enum CourseAPIServiceError: Error {
  case domainError
  case apiError
  case invlaidResponse
  case imageDataError
  case decodingError
  case invalidURL
  case forbidden
  case notFound
  case noData
}
