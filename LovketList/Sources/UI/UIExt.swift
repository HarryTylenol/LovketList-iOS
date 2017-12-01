//
//  UIComponents.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation

class DividerView : UIView {
  
  override func awakeFromNib() {
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1.0;
    
    self.backgroundColor = UIColor.clear
  }
}
