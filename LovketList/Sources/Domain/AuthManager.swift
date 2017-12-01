//
// Created by 박현기 on 2017. 11. 23..
// Copyright (c) 2017 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthManager {
  
  static var uid : String? = nil
  
  class func authCallback(_ onUserAuthCallback: @escaping OnUserAuthCallback) {
    Auth.auth().addStateDidChangeListener { (auth, user) in
      print(user ?? "NULL")
      AuthManager.uid = user?.uid
      onUserAuthCallback(user ?? nil)
    }
  }
  
  class func signIn(email: String, password : String, _ onUserAuthCallback: @escaping OnUserAuthCallback) {
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      print(error ?? "NULL")
      if (error != nil) {
        onUserAuthCallback(nil)
      }
      else {
        AuthManager.uid = user?.uid
        onUserAuthCallback(user ?? nil)
      }
    }
  }
  
  class func login(email: String, password : String, _ onUserAuthCallback: @escaping OnUserAuthCallback) {
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
      print(error ?? "NULL")
      if (error != nil) {
        onUserAuthCallback(nil)
      }
      else {
        AuthManager.uid = user?.uid
        onUserAuthCallback(user ?? nil)
      }
    }
  }
  
}
