//
//  PhotosDataCache.swift
//  SBTask
//
//  Created by Daniel Rybak on 10/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import Foundation

/// Handles Caching for photos
/// Works with Data for future scalability
class PhotosDataCache: PhotosDataCacheProtocol {
  var cache = NSCache<NSString, NSData>()
  
  func get(forKey: String) -> NSData? {
    return cache.object(forKey: NSString(string: forKey))
  }
  
  func set(forKey: String, data: NSData) {
    cache.setObject(data, forKey: NSString(string: forKey))
  }
}

extension PhotosDataCache {
  private static var dataCache = PhotosDataCache()
  static func getDataCache() -> PhotosDataCache {
    return dataCache
  }
}
