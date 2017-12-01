//
//  LovketListCell.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 25..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit

class LovketListItemCell : UITableViewCell {
  
  @IBOutlet var title: UILabel!
  @IBOutlet var content: UILabel!
  @IBOutlet var icon: UIImageView!
  
  let icons = [#imageLiteral(resourceName: "ic_restaurant_menu_18pt"), #imageLiteral(resourceName: "ic_map_18pt"), #imageLiteral(resourceName: "ic_cake_18pt"), #imageLiteral(resourceName: "ic_favorite_18pt"), #imageLiteral(resourceName: "ic_date_range_18pt"), #imageLiteral(resourceName: "ic_flight_18pt")]
  
  func bindData(lovket : Lovket) {
    title.text = lovket.title
    content.text = lovket.content
    icon.image = icons[lovket.type].withRenderingMode(.alwaysTemplate)
  }
  
}
