//
//  LoginPresenterTests.swift
//  SBTaskTests
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//

@testable import SBTask
import XCTest

class LoginPresenterTests: XCTestCase {
  var presenter: LoginPresenter!
  var router: MockLoginRouter!
  
  override func setUp() {
    router = MockLoginRouter()
    presenter = LoginPresenter(interface: LoginViewController(), interactor: nil, router: router)
  }
  
  func test_OnLoginButtonPress_FieldValidationPasses_WhenBothDetailsNotEmpty() {
    presenter.didPressLoginButton(userName: "abc", password: "123")
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenBothDetailsAreEmpty() {
    presenter.didPressLoginButton(userName: "", password: "")
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenUserNameIsEmpty() {
    presenter.didPressLoginButton(userName: "", password: "123")
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenPasswordNameIsEmpty() {
    presenter.didPressLoginButton(userName: "abc", password: "")
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenUserNameIsNil() {
    presenter.didPressLoginButton(userName: nil, password: "123")
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenPasswordNameIsNil() {
    presenter.didPressLoginButton(userName: "abc", password: nil)
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_OnLoginButtonPress_FieldValidationDoesntPass_WhenBothDetailsAreNil() {
    presenter.didPressLoginButton(userName: nil, password: nil)
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
  
  func test_validateFields_RouterNavigatesToPhotos_WhenValidationPassed() {
    presenter.validateFields(validated: true)
    XCTAssertTrue(router.navigateToPhotosCalled)
  }
  
  func test_validateFields_RouterNavigatesToPhotos_WhenValidationDidNotPassed() {
    presenter.validateFields(validated: false)
    XCTAssertFalse(router.navigateToPhotosCalled)
  }
}
