//
//  Common.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit


/// - Note: e.g. `2018-12-10T05:00:00.000Z`
let globalDateFormatter: DateFormatter = {
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "en_US_POSIX")
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  return dateFormatter
}()

/// - Note: e.g. `Dec 11, 1986`
let prettyDateFormatter: DateFormatter = {
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "en_US_POSIX")
  dateFormatter.dateFormat = "MMM dd, yyyy"
  return dateFormatter
}()

extension Date {
  
  init<DateKey>(with container: KeyedDecodingContainer<DateKey>,
                forKey key: KeyedDecodingContainer<DateKey>.Key) throws where DateKey : CodingKey
  {
    let dateString = try container.decode(String.self, forKey: key)
    let debug = "Could not create date from string: \(dateString))"
    guard let date = globalDateFormatter.date(from: dateString) else {
      throw DecodingError.dataCorruptedError(
        forKey: key,
        in: container,
        debugDescription: debug)
    }
    self = date
  }
}

extension URL {
  
  init<URLKey>(with container: KeyedDecodingContainer<URLKey>,
               forKey key: KeyedDecodingContainer<URLKey>.Key) throws where URLKey : CodingKey
  {
    let urlString = try container.decode(String.self, forKey: key)
    let debug = "Could not create url from string: \(urlString),\nfor key: \(key)"
    guard let url = URL(string: urlString) else {
      throw DecodingError.dataCorruptedError(
        forKey: key,
        in: container,
        debugDescription: debug)
    }
    self = url
  }
}

