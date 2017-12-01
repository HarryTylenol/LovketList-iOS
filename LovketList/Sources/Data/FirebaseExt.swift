//
//  FirestoreExt.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 23..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore

typealias OnSuccessCallback =  () -> Void
typealias OnErrorCallback =  (Error) -> Void
typealias QueryCallback<MODEL : FirebaseModel> = ([MODEL]?) -> Void
typealias SingleQueryCallback<MODEL : FirebaseModel> = (MODEL?) -> Void

extension DocumentReference {
  
  func remove(_ onSuccessCallback : @escaping OnSuccessCallback, _ onErrorCallback : @escaping OnErrorCallback) {
    delete() {
      error in
      if error != nil {
        onSuccessCallback()
      } else {
        onErrorCallback(error!)
      }
    }
  }
  
}

extension CollectionReference {
  
  func add(model : FirebaseModel, _ onSuccessCallback : @escaping OnSuccessCallback, _ onErrorCallback : @escaping OnErrorCallback) {
    addDocument(data: model.toMap()) {
      error in
      if error != nil {
        onSuccessCallback()
      } else {
        onErrorCallback(error!)
      }
    }
  }
  
}
