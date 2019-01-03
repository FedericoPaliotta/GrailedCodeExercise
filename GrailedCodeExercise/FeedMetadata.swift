//
//  FeedMetadata.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct FeedMetadata : Codable {
  
  let pagination: FeedPaginationMetadata
  
}

struct FeedPaginationMetadata {
  
  private let _nextPage: String
  private let _currentPage: String
  private let _previousPage: String
 
  var currentPage: Int {
    return page(from: _currentPage)
  }
  
  var nextPage: Int {
    return page(from: _nextPage)
  }
  
  var previousPage: Int {
    return page(from: _previousPage)
  }
  
  private func page(from queryString: String) -> Int {
    let components = URLComponents(string: queryString)
    let pageComponent = components?.queryItems?.last?.value ?? ""
    guard let page = Int(pageComponent) else {
      print(#file, #line, "Unexpected Error: nil or invalid page")
      return -1
    }
    return page
  }
  
}

extension FeedPaginationMetadata : Codable {
  
  private enum FeedPaginationCodingKeys : String, CodingKey {
    case next_page, current_page, previous_page
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedPaginationCodingKeys.self)
    _nextPage = try container.decode(String.self, forKey: .next_page)
    _currentPage = try container.decode(String.self, forKey: .current_page)
    _previousPage = try container.decode(String.self, forKey: .previous_page)
  }
  
}
