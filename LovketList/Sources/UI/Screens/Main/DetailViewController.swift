//
//  DetailViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 28..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import Siesta
import RMDateSelectionViewController

class DetailViewController : UIViewController {
  
  var lovket : Lovket!
  let icons = [#imageLiteral(resourceName: "ic_restaurant_menu_18pt"), #imageLiteral(resourceName: "ic_map_18pt"), #imageLiteral(resourceName: "ic_cake_18pt"), #imageLiteral(resourceName: "ic_favorite_18pt"), #imageLiteral(resourceName: "ic_date_range_18pt"), #imageLiteral(resourceName: "ic_flight_18pt")]
  let keywords = ["food", "place", "celebrate", "love", "calendar", "abroad"]
  
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var addCalendarButton: UIButton!
  @IBAction func onAddCalendarClicked(_ sender: Any) {
    
    let doneAction = RMAction<UIDatePicker>.init(title: "Add", style: RMActionStyle.done) { controller in
      CalendarUtil.addEventToCalendar(title: self.lovket.title, description: self.lovket.content, date : controller.contentView.date)
    }
    
    let cancelAction = RMAction<UIDatePicker>.init(title: "Cancel", style: RMActionStyle.cancel) { controller in
    }
    
    let dateSelectViewController = RMDateSelectionViewController.init(
      style: RMActionControllerStyle.sheetWhite,
      title : "Select Date", message : "Select date to add calendar event",
      select: doneAction, andCancel: cancelAction)!
    
    self.present(dateSelectViewController, animated: true, completion: nil)
    
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.tintColor = UIColor.white
    navigationController?.navigationBar.backgroundColor = UIColor.clear
    navigationController?.navigationBar.barStyle = .blackOpaque
    navigationController?.navigationBar.isTranslucent = true;
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addCalendarButton.layer.cornerRadius = 10
    titleLabel.sizeToFit()
    subtitleLabel.sizeToFit()
    
    iconImageView.image = icons[lovket.type].withRenderingMode(.alwaysTemplate)
    titleLabel.text = lovket.title
    subtitleLabel.text = lovket.content
    
    let images = ImageSaver.images[keywords[lovket.type]]!
    
    backgroundImageView.alpha = 0.0
    backgroundImageView.downloadedFrom(link: images[Int(arc4random_uniform(UInt32(images.count)))], contentMode : .scaleAspectFill) {
      UIView.animate(withDuration: 0.5, animations: {
        self.backgroundImageView.alpha = 1.0
      })
    }
    
  }
  
}
