//
//  URLImage.swift
//  SBTask
//
//  Created by Daniel Rybak on 10/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import UIKit

class URLImage {
  var image: UIImage?
  var urlString: String?
  var imageCache = ImageCache.getImageCache()
  
  init(urlString: String?) {
    self.urlString = urlString
    loadImage()
  }
  
  func loadImage() {
    if loadImageFromCache() {
      return
    }
    
    loadImageFromUrl()
  }
  
  func loadImageFromCache() -> Bool {
    guard let urlString = urlString else {
      return false
    }
    
    guard let cacheImage = imageCache.get(forKey: urlString) else {
      return false
    }
    
    image = cacheImage
    return true
  }
  
  func loadImageFromUrl() {
    guard let urlString = urlString else { return }
    
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data: response: error: ))
    task.resume()
  }
  
  
  func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
    guard error == nil else {
      print("Server error getting URLImage")
      return
    }
    
    guard let data = data else {
      print("No data found for URL Image")
      return
    }
    
    DispatchQueue.main.async {
      guard let loadedImage = UIImage(data: data) else {
        print("Data was found for URL Image")
        return
      }
      
      if let urlString = self.urlString {
        self.imageCache.set(forKey: urlString, image: loadedImage)
        self.image = loadedImage
      }
    }
  }
}

class ImageCache {
  var cache = NSCache<NSString, UIImage>()
  
  func get(forKey: String) -> UIImage? {
    return cache.object(forKey: NSString(string: forKey))
  }
  
  func set(forKey: String, image: UIImage) {
    cache.setObject(image, forKey: NSString(string: forKey))
  }
}

extension ImageCache {
  private static var imageCache = ImageCache()
  static func getImageCache() -> ImageCache {
    return imageCache
  }
}

