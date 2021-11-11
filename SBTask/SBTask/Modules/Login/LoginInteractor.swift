//
//  LoginInteractor.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// Interactor: Responsible for retrieving data from the model layer, it is independent of the user interface.

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
  weak var presenter: LoginInteractorOutputProtocol?
  
  func validateFields(userName: String?, password: String?) {
    let isValid = userName.hasNotEmptyValue && password.hasNotEmptyValue
    presenter?.validateFields(validated: isValid)
  }
}
