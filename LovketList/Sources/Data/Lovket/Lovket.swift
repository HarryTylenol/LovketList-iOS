//
//  Lovket.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 23..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Lovket : FirebaseModel {
  
  static let FOOD = 0
  static let PLACE = 1
  static let BIRTHDAY = 2
  static let LOVE = 3
  static let DATE = 4
  static let TRAVEL = 5

  static let PROGRESS_DONE = 0
  static let PROGRESS_NOT_DONE = 1
  static let PROGRESS_MY_LOVKET = 2

  var time : Date
  var type : Int
  var progress : Int
  var title : String
  var content : String
  var uploadUID : String
  
  func toMap() -> [String : Any] {
    return [
      "time" : FieldValue.serverTimestamp(),
      "type" : type,
      "progress" : progress,
      "title" : title,
      "content" : content,
      "uploadUID" : AuthManager.uid ?? "",
    ]
  }
  
  init(_ data: [String : Any]?) {
    if data != nil {
      type = data!["type"] as? Int ?? 0
      progress = data!["progress"] as? Int ?? 0
      time = data!["time"] as? Date ?? Date()
      title = data!["title"] as? String ?? ""
      content = data!["content"] as? String ?? ""
      uploadUID = data!["uploadUID"] as? String ?? ""
    } else {
      type = 0
      progress = 0
      time = Date()
      title = ""
      content = ""
      uploadUID = ""
    }
  }

}
