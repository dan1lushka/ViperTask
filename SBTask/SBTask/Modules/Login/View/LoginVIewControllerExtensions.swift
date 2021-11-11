//
//  LoginVIewControllerExtensions.swift
//  SBTask
//
//  Created by Daniel Rybak on 09/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import UIKit

// Mark: Constraints handling
extension LoginViewController {
  func configureConstraints() {
    bottomButtonConstraint = loginButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomButtonConstraintAmount)
    bottomButtonConstraint.isActive = true
  }
}

// Mark: Keyboard handling
extension LoginViewController {
  func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func removeKeyboardObserver(){
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      if !isKeyboardShown {
        self.bottomButtonConstraint.constant -= keyboardSize.height
        isKeyboardShown.toggle()
      }
    }
  }
  
  @objc private func keyboardWillHide(notification: NSNotification) {
    if isKeyboardShown {
      self.bottomButtonConstraint.constant = bottomButtonConstraintAmount
      isKeyboardShown.toggle()
    }
  }
}

// Mark: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder() // dismiss keyboard
    return true
  }
}

// Mark: Configures components to be used in viewDidLoad
extension LoginViewController {
  func configure() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
    errorLabel.isHidden = true
  }
  
  func hideErrorLabel(condition: Bool) {
    errorLabel.isHidden = condition
  }
}
