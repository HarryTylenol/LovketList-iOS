//
//  CheckGroupViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 28..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class CheckGroupViewController : UIViewController {
  
  var userRepository : UserRepository!
  var groupRepository : GroupRepository!
  
  @IBAction func onCreateGroupButtonClicked(_ sender: Any) {
    showAlert("make-new-group".localize, "make-new-group-description".localize, true) {
      _ in
      self.showLoadingDialog()
      self.groupRepository.addNewGroup(uid: AuthManager.uid!, singleQueryCallback: { groupKey in
        
        if groupKey == nil {
          return
        }
        
        self.userRepository.addNewUser(groupKey: groupKey!, onSuccessCallback: {
          
          self.dismiss(animated: true, completion: nil)
        }, onErrorCallback: { error in
          
          self.dismiss(animated: true, completion: nil)
        })
        
      }, onErrorCallback: { error in
        
        self.dismiss(animated: true, completion: nil)
      })
    }
  }
  
  @IBAction func onJoinGroupButtonClicked(_ sender: Any) {
    showAlert("join-group".localize, "join-group-description".localize, true) {
      _ in
      self.showLoadingDialog()
      
    }
  }
  
  @IBOutlet var groupCodeField: MDCTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    self.moveViewWhenKeyboardShowing()
    
    _ = groupCodeField.setupColored(self, placeHolderKey: "type-group-code")
  }
  
}
