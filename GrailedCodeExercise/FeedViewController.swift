//
//  FeedViewController.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

  @IBOutlet weak var feedTableView: UITableView!
  
  @IBOutlet weak var searchButtonItem: UIBarButtonItem!
  
  private let feedManager = UserSessionManager.shared.feedManager
  
  private lazy var feedData = feedManager.aggregatedFeed
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupFeedTableView()
    setupObservation()
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  private func setupFeedTableView() {
    feedTableView.dataSource = self
    feedTableView.delegate = self
    feedTableView.refreshControl = UIRefreshControl()
    feedTableView.refreshControl?.backgroundColor = .white
    feedTableView.refreshControl?.tintColor = UIColor.lightGray.withAlphaComponent(0.2)
    feedTableView.refreshControl?.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
  }
  
  private func setupObservation() {
    let name = feedManager.pagesAddedNotificationName
    NotificationCenter.default.addObserver(self, selector:
      #selector(handlePagesAddedNotification(notification:)), name: name, object: nil)
  }

  @objc
  private func refreshFeed() {
    feedData = []
    feedManager.fetchNewestContent()
  }
  
  @objc
  private func handlePagesAddedNotification(notification: Notification) {
    feedTableView.refreshControl?.endRefreshing()
    var lastRowIndex = max(0, feedData.count - 1)
    feedData = feedManager.aggregatedFeed
    let feedPageKey = feedManager.kMoreContentFeedPage
    if let moreContentPage = notification.userInfo?[feedPageKey] as? FeedPage {
      let indexPaths: [IndexPath] = moreContentPage.data.map { _ in
        let indexPath = IndexPath(row: lastRowIndex, section: 0)
        lastRowIndex += 1
        return indexPath
      }
      feedTableView.insertRows(at: indexPaths, with: .bottom)
    } else {
      feedTableView.reloadData()
    }
  }
  
  @objc
  private func pushToSearchViewController() {
    navigationController?.pushViewController(UIViewController(), animated: true)
  }  
}

extension FeedViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return feedData.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: FeedTableViewCell.identifier,
      for: indexPath) as! FeedTableViewCell
    guard indexPath.row < feedData.count else { return cell }
    let article = feedData[indexPath.row]
    cell.configure(with: article)
    return cell
  }
  
}

extension FeedViewController : UITableViewDelegate {

  func tableView(_ tableView: UITableView,
                 willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    guard indexPath.row < feedData.count else { return }
    let imageUrl = feedData[indexPath.row].imageUrl
    let width = Int(tableView.bounds.width)
    displayImage(in: cell as! FeedTableViewCell, for: indexPath, withUrl: imageUrl, width: width)
    let lastRowIndex = self.tableView(tableView, numberOfRowsInSection: 0) - 1
    guard lastRowIndex == indexPath.row else { return }
    feedManager.fetchMoreContent()
  }
  
  func tableView(_ tableView: UITableView,
                 didEndDisplaying cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    guard indexPath.row < feedData.count else { return }
    let imageUrl = feedData[indexPath.row].imageUrl
    let feedImage = LazyImage(imageUrl: imageUrl, imageWidth: Int(tableView.bounds.width))
    ImageDownloadManager.shared.slowImageDownloadPriority(for: feedImage)
  }
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.width + 95
  }
}

