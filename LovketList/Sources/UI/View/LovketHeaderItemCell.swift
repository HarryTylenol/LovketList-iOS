//
//  LovketHeaderItemCell.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 25..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit

class LovketHeaderItemCell : UITableViewCell {
  
  @IBOutlet var seeMoreButton: UIButton!
  @IBOutlet var headerLabel: UILabel!
  @IBOutlet var icon: UIImageView!
  
  let title = ["done-lovket".localize, "not-done-lovket".localize, "my-lovket".localize]
  let icons = [#imageLiteral(resourceName: "ic_check_circle_18pt"), #imageLiteral(resourceName: "ic_help_18pt"), #imageLiteral(resourceName: "ic_person_18pt")]
  
  func bindData(position : Int) {
    seeMoreButton.setTitle("see-more".localize,for: .normal)
    headerLabel.text = title[position]
    icon.image = icons[position].withRenderingMode(.alwaysTemplate)
  }
}
