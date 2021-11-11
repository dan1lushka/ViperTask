//
//  PhotosPresenter.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Presenter: Contains view logic for preparing content for display (as received from the Interactor) and for reacting
// to user inputs (by requesting new data from the Interactor).

import Foundation

class PhotosPresenter: PhotosPresenterProtocol {
  
  weak private var view: PhotosViewProtocol?
  var interactor: PhotosInteractorInputProtocol?
  private let router: PhotosRouterProtocol
  var photos: [Photo]?
  var imageCache: NSCache<NSString, NSData>
  
  init(interface: PhotosViewProtocol, interactor: PhotosInteractorInputProtocol?, router: PhotosRouterProtocol, imageCache: NSCache<NSString, NSData>) {
    self.view = interface
    self.interactor = interactor
    self.router = router
    self.imageCache = imageCache
  }
  
  func viewDidLoad() {
    interactor?.loadPhotos()
  }
  
  func presentImageDataFromNetwork(urlString: String) {
    interactor?.loadDataForImage(urlString: urlString)
  }
  
  func getImageCacheData(for urlString: String) -> Data? {
    if let data = imageCache.object(forKey: NSString(string: urlString)) {
      return data as Data
    }
    return nil
  }
  
  func setImageCacheData(urlString: String, data: Data) {
    imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
  }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
  
  func didFinishLoadingPhotos(_ photos: [Photo]?) {
    // Tell the view to reload.
    self.photos = photos
    view?.reloadData()
  }
  
  func didFinishLoadingDataForImage(data: Data, urlString: String) {
    // Update cache holding urlString and data
    setImageCacheData(urlString: urlString, data: data)
  }
}
