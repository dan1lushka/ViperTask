//
//  PhotosPresenterTests.swift
//  SBTaskTests
//
//  Created by Daniel Rybak on 12/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

@testable import SBTask
import XCTest

class PhotosPresenterTests: XCTestCase {
  var presenter: PhotosPresenter!
  var interactor: MockPhotosInteractor!
  var str = ""
  
  override func setUp() {
    interactor = MockPhotosInteractor()
    presenter = PhotosPresenter(interface: PhotosViewController(), interactor: interactor, router: PhotosRouter(), imageCache: NSCache<NSString, NSData>())
    interactor.presenter = presenter
  }
  
  func test_viewDidLoad_LoadsPhotos_WhenAllGood() {
    presenter.viewDidLoad()
    XCTAssertTrue(presenter.photos?.count == 1)
  }
  
  func test_presentImageDataFromNetwork_LoadsNonEmptyDataToImageCache_WhenDataExists() {
    str = "abc"
    presenter.presentImageDataFromNetwork(urlString: str)
    XCTAssertFalse(presenter.getImageCacheData(for: str)!.isEmpty)
  }
  
  func test_presentImageDataFromNetwork_LoadsEmptyDataToImageCache_WhenDataDoesntExist() {
    str = ""
    presenter.presentImageDataFromNetwork(urlString: str)
    XCTAssertTrue(presenter.getImageCacheData(for: str)!.isEmpty)
  }
  
}
