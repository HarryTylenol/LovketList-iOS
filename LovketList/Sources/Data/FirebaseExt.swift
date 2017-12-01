//
//  FirebaseExt.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 23..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// #define index int
typealias OnSuccessCallback =  () -> Void
typealias OnErrorCallback =  (Error?) -> Void
typealias QueryCallback<MODEL> = ([MODEL]?) -> Void
typealias SingleQueryCallback<MODEL> = (MODEL?) -> Void
typealias OnUserAuthCallback = (FirebaseAuth.User?) -> Void
typealias OnUserDataCallback = (User?) -> Void


extension DocumentSnapshot {
  
  func toLovket() -> Lovket {
    return Lovket(self.data())
  }
  
}

extension DocumentReference {
  
  func remove(_ onSuccessCallback : @escaping OnSuccessCallback, _ onErrorCallback : @escaping OnErrorCallback) {
    delete() {
      error in
      if error != nil {
        onErrorCallback(error!)
      } else {
        onSuccessCallback()
      }
    }
  }
  
}

extension CollectionReference {
  
  func add(model : [String : Any], _ onSuccessCallback : @escaping OnSuccessCallback, _ onErrorCallback : @escaping OnErrorCallback) {
    addDocument(data: model) {
      error in
      if error != nil {
        onErrorCallback(error!)
      } else {
        onSuccessCallback()
      }
    }
  }
  
}
