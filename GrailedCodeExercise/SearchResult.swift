//
//  SearchResult.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct SearchResults : Codable {
  
  let data: [SearchResult]
  
  init?(from data: Data) { // FIXME: make generic
    do {
      self = try JSONDecoder().decode(SearchResults.self, from: data)
    } catch let error {
      print(#file, #line, "Unexpected Error: invalid data", error)
      return nil
    }
  }

}

struct SearchResult {
  
  let id: UInt // FIXME: discuss with backend having the api return this as a string
  let name: String
  let imageUrl: URL
  let itemType: String // FIXME: turn this into an enum
  let isPublished: Bool
  let publishedDate: Date
  let article: Article?
  let search: Search
  
}

extension SearchResult : Codable {
  
  private enum SearchResultCodingKeys : String, CodingKey {
    case id, name, image_url, item_type, published, published_at, article, search
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: SearchResultCodingKeys.self)
    id = try container.decode(UInt.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    imageUrl = try URL(with: container, forKey: .image_url)
    itemType = try container.decode(String.self, forKey: .item_type)
    isPublished = try container.decode(Bool.self, forKey: .published)
    publishedDate = try Date(with: container, forKey: .published_at)
    article = try container.decode(Article?.self, forKey: .article)
    search = try container.decode(Search.self, forKey: .search)
  }
  
}

