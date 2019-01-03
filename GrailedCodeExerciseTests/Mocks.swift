//
//  Mocks.swift
//  GrailedCodeExerciseTests
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct ArticleMock {
  
  static let id = 2248
  static let url = "https://www.grailed.com/drycleanonly/a-cold-wall-nike-air-force-1-low-release-info"
  static let title = "A-Cold-Wall*'s Air Force 1 Lows Receive Release Date"
  static let publishedAt = "2018-12-10T05:00:00.000Z"
  static let isPublished = true
  static let hero = "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/wityEa0WRiaE0hy7X28G"
  static let listings: [String] = []
  static let tags = ["sneakers", "air-force-1", "nike", "a-cold-wall"]
  static let franchise = "News"
  static let slug = "a-cold-wall-nike-air-force-1-low-release-info"
  static let author = "Anteneh Gebre"
  static let contentType = "basic"
  static let position = "tertiary"
  
  static let sampleJson = """
    {
        "id": \(id),
        "url": "\(url)",
        "title": "\(title)",
        "published_at": "\(publishedAt)",
        "published": \(isPublished),
        "hero": "\(hero)",
        "listings": \(listings),
        "tag_list": \(tags),
        "franchise": "\(franchise)",
        "slug": "\(slug)",
        "author": "\(author)",
        "content_type": "\(contentType)",
        "position": "\(position)"
    }
  """
}

struct FeedPageMock {
  
  static let currentPage: Int = 0
  
  static let sampleJson = """
    {
        "data": [
            {
                "id": 2237,
                "url": "https://www.grailed.com/drycleanonly/supreme-holiday-shopping",
                "title": "Holiday 2018: Supreme Steals For Every Budget",
                "published_at": "2018-12-13T05:00:00.000Z",
                "published": true,
                "hero": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/OPdEshq0Qb2QtMaIW5hi",
                "listings": [],
                "tag_list": [
                    "supreme"
                ],
                "franchise": "Staff Picks",
                "slug": "supreme-holiday-shopping",
                "author": "Grailed Team",
                "content_type": "looks",
                "position": "feature"
            },
            {
                "id": 2263,
                "url": "https://www.grailed.com/drycleanonly/weekend-reading-107",
                "title": "Weekend Reading: December 14, 2018",
                "published_at": "2018-12-14T05:00:00.000Z",
                "published": true,
                "hero": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/mdlrVtklStSR03myDFNr",
                "listings": [],
                "tag_list": [
                    "weekend-reading"
                ],
                "franchise": "News",
                "slug": "weekend-reading-107",
                "author": "Grailed Team",
                "content_type": "basic",
                "position": "tertiary"
            }
        ],
        "metadata": {
            "pagination": {
                "next_page": "/api/articles/ios_index?page=1",
                "current_page": "/api/articles/ios_index?page=\(currentPage)",
                "previous_page": "/api/articles/ios_index?page=0"
            }
        }
    }
  """
}


struct SearchResultsMock {
  
  static let count: Int = 5
  
  static let sampleJson = """
    {
        "data": [
            {
                "id": 1032,
                "name": "Off-White Under $300",
                "image_url": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/lzTB8HiESc2GEVdt8SBp",
                "item_type": "saved_search",
                "published": true,
                "published_at": "2018-12-18T15:25:12.123Z",
                "article": null,
                "search": {
                    "uuid": "HkTJNRIOSA",
                    "index_name": "Listing_by_heat",
                    "default_name": null,
                    "query": "",
                    "filters": {
                        "strata": [
                            "grailed",
                            "hype"
                        ],
                        "designers": [
                            205
                        ],
                        "max_price": 300
                    },
                    "url_path": null
                }
            },
            {
                "id": 1018,
                "name": "Common Projects Boots Under $400",
                "image_url": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/cDs33JyThSNki3Kn53h4",
                "item_type": "saved_search",
                "published": true,
                "published_at": "2018-12-11T15:26:37.637Z",
                "article": null,
                "search": {
                    "uuid": "mSw7mVlQvw",
                    "index_name": "Listing_by_heat",
                    "default_name": null,
                    "query": "",
                    "filters": {
                        "strata": [
                            "grailed"
                        ],
                        "designers": [
                            28
                        ],
                        "max_price": 400,
                        "category_paths": [
                            "footwear.boots"
                        ]
                    },
                    "url_path": null
                }
            },
            {
                "id": 1011,
                "name": "Latest Supreme Drop: Accessories",
                "image_url": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/Je5ulCvJQ4CPGKA34cry",
                "item_type": "saved_search",
                "published": true,
                "published_at": "2018-12-06T16:27:48.070Z",
                "article": null,
                "search": {
                    "uuid": "t7PeG7CtrA",
                    "index_name": "Listing_by_date_added",
                    "default_name": null,
                    "query": "",
                    "filters": {
                        "strata": [
                            "basic",
                            "grailed",
                            "hype",
                            "sartorial"
                        ],
                        "designers": [
                            6
                        ],
                        "category_paths": [
                            "accessories.bags_luggage",
                            "accessories.belts",
                            "accessories.glasses",
                            "accessories.gloves_scarves",
                            "accessories.hats",
                            "accessories.jewelry_watches",
                            "accessories.misc",
                            "accessories.periodicals",
                            "accessories.socks_underwear",
                            "accessories.sunglasses",
                            "accessories.supreme",
                            "accessories.ties_pocketsquares",
                            "accessories.wallets"
                        ]
                    },
                    "url_path": null
                }
            },
            {
              "id": 1000,
              "name": "Beyond Rick Owens",
              "image_url": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/zt84YeJfSCeuI5norAxm",
              "item_type": "saved_search",
              "published": true,
              "published_at": "2018-11-28T20:48:48.528Z",
              "article": null,
              "search": {
                  "uuid": "RVarxfhLAg",
                  "index_name": "Listing_by_heat",
                  "default_name": null,
                  "query": "",
                  "filters": {
                      "strata": [
                          "grailed"
                      ],
                      "designers": [
                          1,
                          18,
                          51,
                          93,
                          100,
                          102,
                          114,
                          146,
                          147,
                          261,
                          306,
                          399,
                          615,
                          632,
                          994,
                          1620
                      ]
                  },
                  "url_path": null
              }
            },
            {
                "id": 794,
                "name": "A Classic Finds New Life: Camp Shirts",
                "image_url": "https://d1qz9pzgo5wm5k.cloudfront.net/api/file/bEa598dFTCWXfPtQfgSx",
                "item_type": "saved_search",
                "published": true,
                "published_at": "2018-07-27T15:03:37.373Z",
                "article": null,
                "search": {
                    "uuid": "eXfZryIrLg",
                    "index_name": "Listing",
                    "default_name": null,
                    "query": "camp shirt",
                    "filters": {
                        "strata": [
                            "grailed",
                            "hype"
                        ],
                        "category_paths": [
                            "tops.button_ups",
                            "tops.jerseys",
                            "tops.long_sleeve_shirts",
                            "tops.polos",
                            "tops.short_sleeve_shirts",
                            "tops.sleeveless",
                            "tops.sweaters_knitwear",
                            "tops.sweatshirts_hoodies"
                        ]
                    },
                    "url_path": null
                }
            }
        ]
    }
  """
}
