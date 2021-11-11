//
//  LoginRouter.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Router: Contains navigation logic for describing which screens are shown in which order.

import UIKit

class LoginRouter: LoginRouterProtocol {
  weak var viewController: UIViewController?
  
  func navigateToPhotos() {
    let photos = PhotosModule().build()
    viewController?.navigationController?.pushViewController(photos, animated: true)
  }
}
