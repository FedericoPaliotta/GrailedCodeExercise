//
//  SavedSearchesViewController.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit

class SavedSearchesViewController: UIViewController {
  
  private let searchesManager = UserSessionManager.shared.searchesManager
  private var searchResults = [SearchResult]()
  
  @IBOutlet weak var searchesCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    searchesCollectionView.dataSource = self
    searchesCollectionView.delegate = self
    searchResults = searchesManager.searchResults
    searchesManager.getSavedSearchResults { searchResults in
      self.searchResults = searchResults
      self.searchesCollectionView.reloadData()
    }
  }

  @IBAction func pop(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
}

extension SavedSearchesViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SearchResultCollectionViewCell.identifier,
      for: indexPath) as! SearchResultCollectionViewCell
    guard indexPath.row < searchResults.count else { return cell }
    let savedSearch = searchResults[indexPath.item]
    cell.configure(with: savedSearch)
    return cell
  }
}

extension SavedSearchesViewController : UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    guard indexPath.item < searchResults.count else { return }
    let imageUrl = searchResults[indexPath.row].imageUrl
    let width = Int(searchesCollectionView.bounds.width)
    displayImage(in: cell as! SearchResultCollectionViewCell, for: indexPath, withUrl: imageUrl, width: width)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didEndDisplaying cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    guard indexPath.row < searchResults.count else { return }
    let imageUrl = searchResults[indexPath.row].imageUrl
    let feedImage = LazyImage(imageUrl: imageUrl, imageWidth: Int(collectionView.bounds.width))
    ImageDownloadManager.shared.slowImageDownloadPriority(for: feedImage)
  }
}

extension SavedSearchesViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = (collectionView.bounds.width - 16) / 2
    return CGSize(width: size, height: size)
  }
}
