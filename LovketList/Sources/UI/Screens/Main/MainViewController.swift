//
//  MainViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import Then
import SlideMenuControllerSwift

class MainViewController: SlideMenuController {
  
  var listContainerViewController : ListContainerViewController? = nil
  var navigationDrawerViewController : NavigationDrawerViewController? = nil
  var notificationDrawerViewController : NotificationDrawerViewController? = nil
  
  override func awakeFromNib() {
    
    listContainerViewController = (UIApplication.shared.delegate as! AppDelegate).dependencyInjector?.getViewController("ListContainer")
    navigationDrawerViewController = (UIApplication.shared.delegate as! AppDelegate).dependencyInjector?.getViewController("NavigationDrawer")
    notificationDrawerViewController = (UIApplication.shared.delegate as! AppDelegate).dependencyInjector?.getViewController("NotificationDrawer")
    
    self.mainViewController = UINavigationController(rootViewController: listContainerViewController!)
    self.leftViewController = navigationDrawerViewController
    self.rightViewController = notificationDrawerViewController
    
    super.awakeFromNib()
  }
  
  @objc func openNavigationDrawer() {
    print("openNavigationDrawer")
    self.openLeft()
  }
  
  @objc func openNotificationDrawer() {
    print("openNotificationDrawer")
    self.openRight()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}
