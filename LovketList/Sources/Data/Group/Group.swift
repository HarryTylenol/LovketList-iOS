//
//  Group.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 22..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

struct Group : FirebaseModel {
  
  func toMap() -> [String : Any] {
    return [
      "manUID" : manUID,
      "womanUID" : womanUID,
    ]
  }
  
  init(data: [String : Any]) {
    manUID = data["manUID"] as! String
    womanUID = data["womanUID"] as! String
  }
  
  var manUID : String
  var womanUID : String
 
}
