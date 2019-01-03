//
//  UserSessionManager.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

final class UserSessionManager {
  
  private init() { }
  static let shared = UserSessionManager()
  
  let feedManager = FeedManager() // TODO: implement `FeedManager.init(with accessToken: String = "")`
  let searchesManager = SearchResultsManager()
  
}

