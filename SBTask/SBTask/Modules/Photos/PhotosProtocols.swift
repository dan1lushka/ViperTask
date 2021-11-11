//
//  PhotosProtocols.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Protocols: Define interactions between components of the VIPER module.

import Foundation

// MARK: Router
/// Navigation
protocol PhotosRouterProtocol: AnyObject {
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol PhotosPresenterProtocol: AnyObject {
  var interactor: PhotosInteractorInputProtocol? { get set }
  var photos: [Photo]? { get set }
  var imageCache: NSCache<NSString, NSData> { get set }
  
  func viewDidLoad()
  func presentImageDataFromNetwork(urlString: String)
  func getImageCacheData(for urlString: String) -> Data?
  func setImageCacheData(urlString: String, data: Data)
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol PhotosInteractorInputProtocol: AnyObject {
  var presenter: PhotosInteractorOutputProtocol? { get set }
  var networkService: NetworkServiceProtocol { get set }
  
  func loadPhotos()
  func loadDataForImage(urlString: String)
}

/// Interactor -> Presenter
protocol PhotosInteractorOutputProtocol: AnyObject {
  func didFinishLoadingPhotos(_ photos: [Photo]?)
  func didFinishLoadingDataForImage(data: Data, urlString: String)
}

// MARK: - View
/// Presenter -> ViewController
protocol PhotosViewProtocol: AnyObject {
  var presenter: PhotosPresenterProtocol? { get set }
  
  func reloadData()
}
