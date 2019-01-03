//
//  FeedPage.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct FeedPage : Codable {
  
  let data: [Article]
  let metadata: FeedMetadata
  
  init?(from data: Data) { // FIXME: make generic
    do {
      self = try JSONDecoder().decode(FeedPage.self, from: data)
    } catch let error {
      print(#file, #line, "Unexpected Error: invalid data", error)
      return nil
    }
  }
  
  var currentPage: Int {
    return metadata.pagination.currentPage
  }
  
  var nextPage: Int {
    return metadata.pagination.nextPage
  }
  
  var previousPage: Int {
    return metadata.pagination.previousPage
  }
  
  var isTopPage: Bool {
    return currentPage == 0 && previousPage == 0
  }
}
