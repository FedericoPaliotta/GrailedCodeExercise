//
//  ImageDownloadManager.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import UIKit

typealias ImageDownloadHandler = (UIImage?, URL, IndexPath?, Error?) -> Void

final class ImageDownloadManager {
  
  private init() { }
  static let shared = ImageDownloadManager()
    
  private (set) lazy var imageDownloadQueue: OperationQueue = {
    let queue = OperationQueue()
    queue.name = "com.me.GrailedCodeExercise.imageDownloadQueue"
    queue.qualityOfService = .userInteractive
    return queue
  }()
  
  let imageCache = NSCache<NSString, UIImage>()
  
  func downloadImage(_ feedImage: LazyImage,
                     indexPath: IndexPath?,
                     completionHandler: @escaping ImageDownloadHandler) -> Progress? {
    guard let url = feedImage.sizedImageFetchUrl else {
      print(#file, #line, "Unexpected Error: FeedImage.sizedImageFetchUrl found nil")
      return nil
    }
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
      print(#file, #function, "Returned cached image for url: \(url.absoluteString)")
      completionHandler(cachedImage, url, indexPath, nil)
      let completedProgress = Progress(totalUnitCount: 1)
      completedProgress.completedUnitCount = 1
      return completedProgress
    }
    
    let downloads = imageDownloadQueue.operations as? [ImageDownload]
    let currentDownload = downloads?.filter {
      $0.imageUrl?.absoluteString == url.absoluteString &&
      $0.isFinished == false && $0.isExecuting == true
    }.first
    if let currentImageDownload = currentDownload {
      currentImageDownload.queuePriority = .veryHigh
      return currentDownload?.progress
    }
    
    let newImageDownload = ImageDownload(imageUrl: url, indexPath: indexPath)
    if indexPath == nil {
      newImageDownload.queuePriority = .veryHigh
    }
    newImageDownload.downloadHandler = { image, url, indexPath, error in
      if let newImage = image {
        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
      }
      completionHandler(image, url, indexPath, error)
    }
    imageDownloadQueue.addOperation(newImageDownload)
    return newImageDownload.progress
  }
  
  func slowImageDownloadPriority(for feedImage: LazyImage) {
    guard let url = feedImage.sizedImageFetchUrl else {
      print(#file, #line, "Unexpected Error: FeedImage.sizedImageFetchUrl found nil")
      return
    }
    let downloads = imageDownloadQueue.operations as? [ImageDownload]
    let currentDownload = downloads?.filter {
      $0.imageUrl?.absoluteString == url.absoluteString &&
        $0.isFinished == false && $0.isExecuting == true
      }.first
    if let currentImageDownload = currentDownload {
      currentImageDownload.queuePriority = .low
    }
  }
}
