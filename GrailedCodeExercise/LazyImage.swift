//
//  FeedImage.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/18/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

struct LazyImage {
  
  let imageUrl: URL
  let imageWidth: Int
  
  var sizedImageFetchUrl: URL? {
    let renderScreenFactor = 3
    let width = imageWidth * renderScreenFactor
    return URL(string: "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:\(width),fit:crop/output=format:jpg,compress:true,quality:95/\(imageUrl.absoluteString)")
  }
  
}
