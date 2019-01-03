//
//  FeedManager.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

final class FeedManager {
  
  init() {
    getFeedPage(nextFeedPage)
  }
  
  let kUpdatedFeedPages = "updatedFeedPages"
  let kMoreContentFeedPage = "moreContentFeedPage"
  let pagesAddedNotificationName = Notification.Name("isMorePagesAddedEvent")

                                             // init,more,more...
  private (set) var feedPages = [FeedPage]() // [p0,p1,p2...
  
  /// - Note: this obviously comes at a cost of space efficiency,
  ///         but it also surely make it a lot more faster, comparend
  ///         to compute every time doing a flatMap over each feedPage element
  private (set) var aggregatedFeed = [Article]()
  
  private var canLoadMorePages = true
  
  private var nextFeedPage: UInt {
    return UInt(feedPages.count)
  }
  
  private func setFeedPages(with feedPage: FeedPage) {
    // FIXME: this mechanism has to be put in place because of a flaw in the api.
    //        The server keeps returning feed pages until page 99, and starts returning a 422 staus code (Unprocessable Entity) after.
    //        Although starting form around page 56, and on until page 99, the server keeps returning a feed page with empty data.
    //        Yet increasing the number of pages reported in the metadata, as if there were actually more next pages.
    //        IMO the api should signal this event to the client by the same sort of behavior adopted in the previous page case.
    //        Just like current and previews page will both be 0, when there are no more previous pages.
    //        So the current and the next page should have the same page number in case there are no more available next pages
    
    //        I do also have further questions about the naming conventioin between next and previous.
    //        It could be more straightforward to think about these in terms of publication date.
    //        This is quite the case already, in the sense that the articles are ordered by published date
    //        Although there is a bug: in some of the pages the article at index 0, will have a timestamp
    //        that is older than the article at index 1; and then correctly decreasing towards earlier timestamp,
    //        But bug aside, it occurs to me that it somewhat confusing and logically reversed, the fact that to fetch
    //        "older" articles the client would have to fetch the *next* page (rather that the previous).
    
    //        So this is definitely something I'd like to discuss with the backend engineers.
    
    let hasReachedBottomFeed = feedPage.data.isEmpty && nextFeedPage > 0
    if hasReachedBottomFeed  {
      canLoadMorePages = false
      return
    }
    feedPages.append(feedPage)
    aggregatedFeed.append(contentsOf: feedPage.data)
    let info: [String : Any]
    if feedPage.currentPage == 0 {
      info = [kUpdatedFeedPages : feedPages]
    } else {
      info = [kUpdatedFeedPages : feedPages, kMoreContentFeedPage : feedPage]
    }
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: self.pagesAddedNotificationName,
                                      object: self, userInfo: info)
    }
  }
  
  private func getFeedPage(_ page: UInt) {
    let getFeedUrl = URL(string: "https://www.grailed.com/api/articles/ios_index?page=\(page)")!
    let getFeedUrlRequest = URLRequest(url: getFeedUrl)
    NetworkManager.shared.send(getFeedUrlRequest, completion: feedResponseHandler)
  }
  
  private func feedResponseHandler(result: NetworkResult) {
    switch result {
    case .success(status: _, data: let feedPageData):
      if let feedPage = FeedPage(from: feedPageData) {
        setFeedPages(with: feedPage)
      }
    case .failure(response: _, statusCode: _, error: let error, message: let message):
      print(#file, #line, message ?? "", error ?? "")
      // TODO: handle failure gracefully
    }
  }

}


// MARK: - Exposed functions
extension FeedManager {
  
  func fetchNewestContent() {
    canLoadMorePages = true
    feedPages = []
    aggregatedFeed = []
    getFeedPage(nextFeedPage)
  }
  
  func fetchMoreContent() {
    guard canLoadMorePages else {
      print(#file, #function, "The feed has already reached the latest page")
      return
    }
    getFeedPage(nextFeedPage)
  }
  
}
