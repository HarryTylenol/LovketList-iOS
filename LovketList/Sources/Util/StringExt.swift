//
//  StringExt.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 24..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

extension String {
  
  var localize: String {
    return NSLocalizedString(self, comment: "nil")
  }
  
}
