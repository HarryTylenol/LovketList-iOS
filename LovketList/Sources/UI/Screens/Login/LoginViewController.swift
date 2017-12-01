//
//  ViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 20..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class SignInViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet var passwordCheckField: MDCTextField!
  @IBOutlet var passwordField: MDCTextField!
  @IBOutlet var emailField: MDCTextField!
  
  @IBAction func onSignUpButtonClicked(_ sender: Any) {
    
    if (emailField.text == nil || passwordField.text == nil || passwordCheckField.text == nil
      || emailField.text!.isEmpty || passwordField.text!.isEmpty || passwordCheckField.text!.isEmpty) {
      showAlert("signin-error".localize, "signin-error-empty".localize)
      return
    }
    
    if (passwordField.text!.count < 6) {
      showAlert("signin-error".localize, "signin-error-password-length".localize)
      return
    }
    
    if (passwordCheckField.text != passwordField.text) {
      showAlert("signin-error".localize, "signin-error-password-check".localize)
      return
    }
    
    AuthManager.signIn(email: emailField.text!, password: passwordField.text!) { user in
      if (user == nil) {
        
        return
      } else {
        self.dismiss(animated: true, completion: nil)
      }
    }
    
  }
  
  @IBAction func onBackButtonClicked(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    self.moveViewWhenKeyboardShowing()
    
    emailField.delegate = self
    passwordField.delegate = self
    passwordCheckField.delegate = self
    
    _ = emailField.setup(self, placeHolderKey: "email")
    
    _ = passwordField.setup(self, placeHolderKey: "password")
    
    _ = passwordCheckField.setup(self, placeHolderKey: "password-check")
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  var userRepository: UserRepository? = nil
  
  @IBOutlet var emailField: MDCTextField!
  @IBOutlet var passwordField: MDCTextField!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    self.moveViewWhenKeyboardShowing()
    
    _ = emailField.setupLight(self, placeHolderKey: "email")
    _ = passwordField.setupLight(self, placeHolderKey: "password")
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  @IBAction func onLoginButtonClicked(_ sender: Any) {
    self.showLoadingDialog()
    AuthManager.login(email: emailField.text!, password: passwordField.text!) {
      user in
      if user != nil {
        print("Success")
        
        
        
      } else {
        print("Failed")
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  @IBAction func onSignInButtonClicked(_ sender: Any) {
    self.present(self.storyboard!.instantiateViewController(withIdentifier: "SignIn"), animated: true, completion: nil)
  }
  
  
}

