//
//  SearchResultsManager.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

final class SearchResultsManager {
  
  private (set) var searchResults = [SearchResult]()
  
  /// - Note: completion handlers passed to this function are
  ///         guaranteed to be executed on the main thread.
  func getSavedSearchResults(completion: @escaping ([SearchResult]) -> Void) { // FIXME: callbacks hell
    let getResultsUrl = URL(string: "https://www.grailed.com/api/merchandise/marquee")!
    let getResultsUrlRequest = URLRequest(url: getResultsUrl)
    NetworkManager.shared.send(getResultsUrlRequest) { result in
      self.completionResponseHandler(result: result, completion: completion)
    }
  }
  
  private func completionResponseHandler(result: NetworkResult,
                                         completion: @escaping ([SearchResult]) -> Void) {
    switch result {
    case .success(status: _, data: let savedSearchesData):
      if let searchResults = SearchResults(from: savedSearchesData)?.data {
        self.searchResults = searchResults
        DispatchQueue.main.async {
          completion(searchResults)
        }
      }
    case .failure(response: _, statusCode: _, error: let error, message: let message):
      print(#file, #line, message ?? "", error ?? "")
      // TODO: handle failure gracefully
    }
  }
}
