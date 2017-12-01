//
//  Module.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import Swinject


protocol Module {
  func build(container : Container)
}

protocol StoryboardModule {
  func build(container : Container)
}
