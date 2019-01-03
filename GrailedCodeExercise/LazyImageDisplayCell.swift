//
//  LazyImageDisplayCell.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 1/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

protocol LazyImageDisplayCell : class {
  var lazyImageView: UIImageView { get }
  var loadProgress: Progress? { get set }
}


func displayImage<LazyCell>(in cell: LazyCell,
                            for indexPath: IndexPath,
                            withUrl imageUrl: URL,
                            width: Int) where LazyCell : LazyImageDisplayCell {
  let feedImage = LazyImage(imageUrl: imageUrl, imageWidth: width)
  let progress = ImageDownloadManager.shared.downloadImage(feedImage, indexPath: indexPath)
  { image, url, path, error in
    guard url == feedImage.sizedImageFetchUrl, indexPath == path else { return }
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
        cell.lazyImageView.image = image
        cell.lazyImageView.alpha = 1
      }, completion: nil)
    }
  }
  cell.loadProgress = progress
}
