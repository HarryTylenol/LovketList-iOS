//
//  Group.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 22..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

struct Group: FirebaseModel {

    func toMap() -> [String: Any] {
        return [
            "tokens": tokens,
        ]
    }

    init(_ data: [String: Any]?) {
        tokens = data?["tokens"] as! [String : String]
    }

    var tokens : [String : String]

}
