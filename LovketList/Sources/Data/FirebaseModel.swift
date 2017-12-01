//
//  FirebaseModel.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 22..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

protocol FirebaseModel {
    func toMap() -> [String: Any]
    init(_ data: [String: Any]?)
}
