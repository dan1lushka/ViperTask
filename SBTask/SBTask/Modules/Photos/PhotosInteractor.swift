//
//  PhotosInteractor.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Interactor: Responsible for retrieving data from the model layer, it is independent of the user interface.

import Foundation

class PhotosInteractor: PhotosInteractorInputProtocol {
  
  var networkService: NetworkServiceProtocol
  weak var presenter: PhotosInteractorOutputProtocol?
  let photosUrlString = "https://jsonplaceholder.typicode.com/photos"
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
  func loadPhotos() {
    // Do network request here and call back the presenter on success.
    print("Loading photos")
    networkService.performNetworkCall(urlString: photosUrlString, objectType: [Photo].self, completion: { photos in
      if let photos = photos { self.presenter?.didFinishLoadingPhotos(photos) }
    })
  }
  
  func loadDataForImage(urlString: String) {
    // Performs a get request for each url passed to it to give back data to construct UIImage in view
    networkService.urlStringToData(urlString: urlString) { data in
      if let data = data {
        self.presenter?.didFinishLoadingDataForImage(data: data as Data, urlString: urlString)
      }
    }
  }
}
