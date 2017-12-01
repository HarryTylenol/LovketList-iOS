//
//  NavigationDrawerViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit

class NavigationDrawerViewController : UIViewController {
  @IBOutlet var bucketTemperatureLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bucketTemperatureLabel.text = "\(90)°C"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}
