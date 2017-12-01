//
// Created by 박현기 on 2017. 11. 23..
// Copyright (c) 2017 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore

class LovketRepository {
  
  var firestore: Firestore
  
  init(firestore: Firestore) {
    self.firestore = firestore
  }
  
  static let PROGRESS_DONE = "done"
  static let PROGRESS_DENIED = "denied"
  static let PROGRESS_NOT_DONE = "not-done"
  static let GROUP = "group"
  
  func queryOnlyFiveLovket(progress: String, groupKey: String, queryCallback: @escaping QueryCallback<Lovket>) {
    
    let query = firestore.collection(LovketRepository.GROUP)
      .document(groupKey)
      .collection(progress)
      .order(by: "time", descending: true)
      .limit(to: 5)
    
    query.getDocuments { (querySnapshot, error) in
      guard querySnapshot != nil else {
        print("Error : \(error.debugDescription)")
        queryCallback([])
        return
      }
      
      guard (querySnapshot?.documents.last) != nil else {
        queryCallback([])
        return
      }
      
      queryCallback(querySnapshot?.documents.flatMap({ Lovket(data: $0.data()) }))
    }
    
  }
  
  func queryByProgress(progress: String, groupKey: String,
                       _ lastDocumentSnapshot: DocumentSnapshot? = nil,
                       queryCallback: @escaping QueryCallback<DocumentSnapshot>) {
    
    var query = firestore.collection(LovketRepository.GROUP)
      .document(groupKey)
      .collection(progress)
      .order(by: "time", descending: true)
      .limit(to: 20)
    
    if lastDocumentSnapshot != nil {
      query = query.start(afterDocument: lastDocumentSnapshot!)
    }
    
    query.getDocuments { (querySnapshot, error) in
      
      guard querySnapshot != nil else {
        print("Error : \(error.debugDescription)")
        return
      }
      
      guard (querySnapshot?.documents.last) != nil else {
        return
      }
      
      queryCallback(querySnapshot?.documents)
      
    }
    
  }
  
}
