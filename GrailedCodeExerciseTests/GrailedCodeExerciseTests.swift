//
//  GrailedCodeExerciseTests.swift
//  GrailedCodeExerciseTests
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest
@testable import GrailedCodeExercise

class GrailedCodeExerciseTests: XCTestCase {
  
  func testInitArticle() {

    let articleData = ArticleMock.sampleJson.data(using: .utf8)!
    let article = try! JSONDecoder().decode(Article.self, from: articleData)
    
    print(article)
    
    XCTAssert(article.id == ArticleMock.id)
    XCTAssert(article.articleUrl.absoluteString == ArticleMock.url)
    XCTAssert(article.title == ArticleMock.title)
    XCTAssert(article.publishedDate == globalDateFormatter.date(from: ArticleMock.publishedAt))
    XCTAssert(article.isPublished == ArticleMock.isPublished)
    XCTAssert(article.imageUrl.absoluteString == ArticleMock.hero)
    XCTAssert(article.listings == ArticleMock.listings)
    XCTAssert(article.tags == ArticleMock.tags)
    XCTAssert(article.category == ArticleMock.franchise)
    XCTAssert(article.slug == ArticleMock.slug)
    XCTAssert(article.contentType == ArticleMock.contentType)
    XCTAssert(article.position == ArticleMock.position)

  }
  
  func testFeedPage() {

    let feedPageData = FeedPageMock.sampleJson.data(using: .utf8)!
    let feedPage = try! JSONDecoder().decode(FeedPage.self, from: feedPageData)
    
    print(feedPage)
    
    XCTAssert(feedPage.currentPage == FeedPageMock.currentPage)
  }
  
  func testSearchResults() {
    
    let searchResultsData = SearchResultsMock.sampleJson.data(using: .utf8)!
    let searchResults = try! JSONDecoder().decode(SearchResults.self, from: searchResultsData)
    
    print(searchResults)
    
    XCTAssert(searchResults.data.count == SearchResultsMock.count)
  }


//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
