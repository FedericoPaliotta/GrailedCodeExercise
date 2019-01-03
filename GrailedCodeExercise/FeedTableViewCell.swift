//
//  FeedTableViewCell.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/16/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
  
  private var article: Article?

  var progress: Progress?
  
  @IBOutlet weak var articleImageView: UIImageView!
  
  @IBOutlet weak var articleTitleLabel: UILabel!
  
  @IBOutlet weak var publishedDateLabel: UILabel!
  
  static let identifier: String = {
    return String(describing: FeedTableViewCell.self)
  }()
  
  override func prepareForReuse() {
    article = nil
    progress = nil
    articleTitleLabel.text = ""
    publishedDateLabel.text = ""
    articleImageView.image = UIImage()
    UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
      self.articleImageView.alpha = 0
    }, completion: nil)
  }

  func configure(with article: Article) {
    self.article = article
    articleTitleLabel.text = article.title
    publishedDateLabel.text = prettyDateFormatter.string(from: article.publishedDate)
  }
}

extension FeedTableViewCell : LazyImageDisplayCell {
  
  var lazyImageView: UIImageView {
    return articleImageView 
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
