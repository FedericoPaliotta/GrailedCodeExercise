//
//  Search.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct Search {
  
  let uuid: String
  let indexName: String
  let defaultName: String?
  let query: String
  let filters: SearchFilter
  let urlPath: String?
  
}

extension Search : Codable {
  
  private enum SearchCodingKeys : String, CodingKey {
    case uuid, index_name, default_name, query, filters, url_path
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: SearchCodingKeys.self)
    uuid = try container.decode(String.self, forKey: .uuid)
    indexName = try container.decode(String.self, forKey: .index_name)
    defaultName = try container.decode(String?.self, forKey: .default_name)
    query = try container.decode(String.self, forKey: .query)
    filters = try container.decode(SearchFilter.self, forKey: .filters)
    urlPath = try container.decode(String?.self, forKey: .url_path)
  }
  
}
