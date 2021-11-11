//
//  LoginProtocols.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Protocols: Define interactions between components of the VIPER module.

import Foundation

// MARK: - View
/// Presenter -> ViewController
protocol LoginViewProtocol: AnyObject {
  var presenter: LoginPresenterProtocol? { get set }
  
  func configure()
  func hideErrorLabel(condition: Bool)
}

// MARK: - Presenter
/// ViewController -> Presenter
protocol LoginPresenterProtocol: AnyObject {
  var interactor: LoginInteractorInputProtocol? { get set }
  
  func viewDidLoad()
  func didPressLoginButton(userName: String?, password: String?)
}

// MARK: - Interactor
/// Presenter -> Interactor
protocol LoginInteractorInputProtocol: AnyObject {
  var presenter: LoginInteractorOutputProtocol? { get set }
  
  func validateFields(userName: String?, password: String?)
}

/// Interactor -> Presenter
protocol LoginInteractorOutputProtocol: AnyObject {
  func validateFields(validated: Bool)
}

// MARK: Router
/// Navigation
protocol LoginRouterProtocol: AnyObject {
  func navigateToPhotos()
}
