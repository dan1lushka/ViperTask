//
//  LoginViewController.swift
//  SBTask
//
//  Created by Julien Claverie on 05/11/2019.
//  Copyright © 2019 The Beans Group. All rights reserved.
//
// View: Displays what the Presenter tells it to display and relays user input back to the Presenter.

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
  
  var presenter: LoginPresenterProtocol?
  
  let bottomButtonConstraintAmount: CGFloat = -50
  var bottomButtonConstraint = NSLayoutConstraint()
  var isKeyboardShown = false
  
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButtonStackView: UIStackView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBAction func loginButtonAction(_ sender: UIButton) {
    guard let presenter = presenter else { return }
    self.view.endEditing(true) //Hides keyboard when button is pressed
    presenter.didPressLoginButton(userName: emailTextField.text, password: passwordTextField.text)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = true
    self.configureConstraints()
    self.addKeyboardObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.removeKeyboardObserver()
  }
}
