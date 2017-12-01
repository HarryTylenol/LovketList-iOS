//
//  Lovket.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 23..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

struct Lovket : FirebaseModel {
  
  static let FOOD = 0
  static let PLACE = 1
  static let BIRTHDAY = 2
  static let LOVE = 3
  static let DATE = 4
  static let TRAVEL = 5

  var time : Int64
  var type : Int
  var title : String
  var content : String
  var uploadUID : String
  
  func toMap() -> [String : Any] {
    return [
      "time" : time,
      "type" : type,
      "title" : title,
      "content" : content,
      "uploadUID" : uploadUID,
    ]
  }
  
  init(data: [String : Any]) {
    type = data["type"] as! Int
    time = data["time"] as! Int64
    title = data["title"] as! String
    content = data["content"] as! String
    uploadUID = data["uploadUID"] as! String
  }

}
