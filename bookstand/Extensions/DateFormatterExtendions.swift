//
//  DateFormatterExtendions.swift
//  bookstand
//
//  Created by Won on 2019/09/27.
//  Copyright © 2019 Won. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale.current
    return formatter
  }()
}

// https://useyourloaf.com/blog/swift-codable-with-custom-dates/
