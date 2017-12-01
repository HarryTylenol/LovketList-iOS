//
//  UIComponents.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
extension UIImageView {
  func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, callback : @escaping () -> Void) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
        callback()
      }
      }.resume()
  }
  func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, _ callback : @escaping () -> Void = {}) {
    guard let url = URL(string: link) else { return }
    downloadedFrom(url: url, contentMode: mode, callback : callback)
  }
}
extension MDCTextField {
  
  func setup(_ viewController : UIViewController, placeHolderKey : String) -> MDCTextInputControllerDefault {
    self.cursorColor = viewController.view.tintColor
    self.tintColor = viewController.view.tintColor
    self.placeholder = placeHolderKey.localize
    return MDCTextInputControllerDefault(textInput: self).then {
      $0.inlinePlaceholderFont = self.font
      $0.leadingUnderlineLabelFont = self.font
      $0.trailingUnderlineLabelFont = self.font
      $0.isFloatingEnabled = false
      $0.activeColor = viewController.view.tintColor
      $0.disabledColor = UIColor.lightGray
      $0.normalColor = UIColor.lightGray
    }
  }
  
  func setupLight(_ viewController : UIViewController, placeHolderKey : String) -> MDCTextInputControllerDefault {
    self.cursorColor = UIColor.white
    self.tintColor = UIColor.white
    self.textColor = UIColor.white
    self.placeholder = placeHolderKey.localize
    
    return MDCTextInputControllerDefault(textInput: self).then {
      $0.inlinePlaceholderFont = self.font
      $0.leadingUnderlineLabelFont = self.font
      $0.trailingUnderlineLabelFont = self.font
      $0.isFloatingEnabled = false
      $0.inlinePlaceholderColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
      $0.activeColor = UIColor.white
      $0.disabledColor = UIColor.white
      $0.normalColor = UIColor.white
    }
  }
  
  func setupColored(_ viewController : UIViewController, placeHolderKey : String) -> MDCTextInputControllerDefault {
    self.cursorColor = viewController.view.tintColor
    self.tintColor = viewController.view.tintColor
    self.textColor = viewController.view.tintColor
    self.placeholder = placeHolderKey.localize
    
    return MDCTextInputControllerDefault(textInput: self).then {
      $0.inlinePlaceholderFont = self.font
      $0.leadingUnderlineLabelFont = self.font
      $0.trailingUnderlineLabelFont = self.font
      $0.isFloatingEnabled = false
      $0.inlinePlaceholderColor = viewController.view.tintColor
      $0.activeColor = viewController.view.tintColor
      $0.disabledColor = viewController.view.tintColor
      $0.normalColor = viewController.view.tintColor
    }
  }
}

extension UIViewController {

  func showAlert(_ title : String,_ content : String, _ cancelable : Bool = false, _ handler : @escaping (UIAlertAction) -> Void = {_ in }) {
    let alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: "ok".localize, style: UIAlertActionStyle.default, handler: handler))
    if cancelable {
      alertController.addAction(UIAlertAction(title: "cancel".localize, style: UIAlertActionStyle.cancel, handler: nil))
    }
    present(alertController, animated : true, completion: nil)
  }

  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  func moveViewWhenKeyboardShowing()  {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func showLoadingDialog() {
    let alert = UIAlertController(title: nil, message: "loading".localize, preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc func keyboardWillShow(sender: NSNotification) {
    self.view.frame.origin.y = -150 // Move view 150 points upward
  }
  
  @objc func keyboardWillHide(sender: NSNotification) {
    self.view.frame.origin.y = 0 // Move view to original position
  }
  
}
