//
//  SearchFilter.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct SearchFilter {
  
  let strata: [String]
  let designers: [String]?
  let categoryPaths: [String]?
  let maxPrice: UInt?
}

extension SearchFilter : Codable {
  
  private enum SearchFilterCodingKeys : String, CodingKey {
    case strata, designers, category_paths, max_price
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: SearchFilterCodingKeys.self)
    strata = try container.decode([String].self, forKey: .strata)
    designers = try? container.decode([String].self, forKey: .designers)
    categoryPaths = try? container.decode([String].self, forKey: .category_paths)
    maxPrice = try? container.decode(UInt.self, forKey: .max_price)
  }
  
}
