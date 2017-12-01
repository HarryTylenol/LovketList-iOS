//
// Created by 박현기 on 2017. 11. 23..
// Copyright (c) 2017 박현기. All rights reserved.
//

import Foundation

struct User : FirebaseModel {
  
    func toMap() -> [String: Any] {
        return [
            "groupKey" : groupKey
        ]
    }
  
    init(_ data: [String: Any]?) {
        groupKey = data?["groupKey"] as! String
    }

    var groupKey : String = ""

}
