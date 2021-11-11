//
//  MockPhotosInteractor.swift
//  SBTaskTests
//
//  Created by Daniel Rybak on 12/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

@testable import SBTask
import Foundation

class MockPhotosInteractor: PhotosInteractorInputProtocol {

  var presenter: PhotosInteractorOutputProtocol? = PhotosPresenter(interface: PhotosViewController(), interactor: nil, router: PhotosRouter(), imageCache: NSCache<NSString, NSData>())
  var networkService: NetworkServiceProtocol = NetworkService()
  
  
  func loadPhotos() {
    presenter?.didFinishLoadingPhotos([Photo(thumbnailUrl: "url", title: "title")])
  }
  
  func loadDataForImage(urlString: String) {
    if urlString == "" {
      presenter?.didFinishLoadingDataForImage(data: Data(), urlString: urlString)
    } else {
      presenter?.didFinishLoadingDataForImage(data: "Data".data(using: .ascii)!, urlString: urlString)
    }
  }
}
