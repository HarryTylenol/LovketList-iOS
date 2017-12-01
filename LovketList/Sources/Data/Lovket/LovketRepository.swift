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
  
  static var documentLists = [[DocumentSnapshot](), [DocumentSnapshot](), [DocumentSnapshot]()]
  class func refreshList() {
    LovketRepository.documentLists = [[DocumentSnapshot](), [DocumentSnapshot](), [DocumentSnapshot]()]
  }
  
  func addNewLovket(lovket: Lovket, onSuccessCallback : @escaping OnSuccessCallback, onErrorCallback : @escaping OnErrorCallback) {
    
    // User 가 Null 이면 Group Key 를 받아올 수 없기 때문에 에러로 처리해줍니다.
    if UserRepository.user == nil {
      print("Error UserRepository.user is null")
      onErrorCallback(nil)
      return
    }
    
    self.firestore.collection(GroupRepository.GROUP)
      .document(UserRepository.user!.groupKey)
      .collection("lovket")
      .add(model: lovket.toMap(), onSuccessCallback, onErrorCallback)
    
  }
  
  // Lovket 을 Progress 에 따라 쿼리하는 부분
  func queryLovket(progress: Int, onSuccessCallback : @escaping OnSuccessCallback, onErrorCallback : @escaping OnErrorCallback) {
    
    // User 가 Null 이면 Group Key 를 받아올 수 없기 때문에 에러로 처리해줍니다.
    if UserRepository.user == nil {
      print("Error UserRepository.user is null")
      onErrorCallback(nil)
      return
    }
    
    // Query 작성
    // /group/{GROUP_KEY}/lovket/{PROGRESS} 에서 PROGRESS 에 따라 쿼리
    // 10 개씩 가져옴
    var query = self.firestore.collection(GroupRepository.GROUP)
      .document(UserRepository.user!.groupKey).collection("lovket")
      .whereField("progress", isEqualTo: progress)
      .order(by: "time", descending : true)
      .limit(to: 10)
    
    // 만약에 이전에 불러온 내역이 있으면 마지막 DocumentSnapshot 부터 Query 시작.
    if (!LovketRepository.documentLists[progress].isEmpty) {
      query = query.start(afterDocument: LovketRepository.documentLists[progress].last!)
    }
    
    // Query 하는 부분
    query.getDocuments { (q, e) in
      if e != nil {
        print("Error queryLovket \(e!)")
        onErrorCallback(e!)
      } else if q != nil {
        
        print("Success queryLovket \(q!.documents)")
        LovketRepository.documentLists[progress] += q!.documents
        onSuccessCallback()
        
      } else {
        print("Error queryLovket \(progress)")
        onErrorCallback(nil)
      }
    }
    
  }
  
}
