//
//  SearchResultCollectionViewCell.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
  
  private var savedSearch: SearchResult?
  
  var progress: Progress?

  @IBOutlet weak var imageView: UIImageView!
 
  @IBOutlet weak var titleLabel: UILabel!
  
  static let identifier: String = {
    return String(describing: SearchResultCollectionViewCell.self)
  }()
  
  override func prepareForReuse() {
    savedSearch = nil
    progress = nil
    imageView.image = UIImage()
    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
      self.imageView.alpha = 0
    }, completion: nil)
  }
  
  func configure(with savedSearch: SearchResult) {
    self.savedSearch = savedSearch
    titleLabel.text = savedSearch.name
  }

}

extension SearchResultCollectionViewCell : LazyImageDisplayCell {
  
  var lazyImageView: UIImageView {
    return imageView
  }
  
  var loadProgress: Progress? {
    get {
      return progress
    }
    set {
      progress = newValue
    }
  }
}
