//
//  Article.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation


struct Article {
  
  let id: UInt // FIXME: discuss with backend having the api return this as a string
  let title: String
  let author: String
  let articleUrl: URL
  let imageUrl: URL
  let publishedDate: Date
  let isPublished: Bool
  let category: String? // FIXME: discuss with backend the best naming convention between `category` and `franchise`
  let listings: [String] // FIXME: make sure that the type returned from the api is actually `[String]`
  let tags: [String]
  let slug: String
  let contentType: String // FIXME: check with backend what are the other cases and turn this into an enum
  let position: String

}

extension Article : Codable {
  
  private enum ArticleCodingKeys : String, CodingKey {
    case id, url, title, published_at, published
    case hero, listings, tag_list, franchise
    case slug, author, content_type, position
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
    id = try container.decode(UInt.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    author = try container.decode(String.self, forKey: .author)
    articleUrl = try URL(with: container, forKey: .url)
    imageUrl = try URL(with: container, forKey: .hero)
    publishedDate = try Date(with: container, forKey: .published_at)
    isPublished = try container.decode(Bool.self, forKey: .published)
    category = try container.decode(String?.self, forKey: .franchise) // FIXME: feed page 52 contains a null frachise field, this is likely to be a bug: double check with the backend engineers 
    listings = try container.decode([String].self, forKey: .listings)
    tags = try container.decode([String].self, forKey: .tag_list)
    slug = try container.decode(String.self, forKey: .slug)
    contentType = try container.decode(String.self, forKey: .content_type)
    position = try container.decode(String.self, forKey: .position)
  }
  
}
