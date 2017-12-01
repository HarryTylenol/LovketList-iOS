//
//  AddViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 29..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import Then
import MaterialComponents

class AddViewController : UIViewController {
  
  let icons = [#imageLiteral(resourceName: "ic_restaurant_menu_18pt"), #imageLiteral(resourceName: "ic_map_18pt"), #imageLiteral(resourceName: "ic_cake_18pt"), #imageLiteral(resourceName: "ic_favorite_18pt"), #imageLiteral(resourceName: "ic_date_range_18pt"), #imageLiteral(resourceName: "ic_flight_18pt")]
  let keywords = ["food", "place", "celebrate", "love", "calendar", "abroad"]
  var type = 3
  
  lazy var lovketRepository : LovketRepository = AppDelegate.di.inject(LovketRepository.self)
  
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var typeChangeButton: MDCFloatingButton!
  @IBOutlet var subtitleField: MDCTextField!
  @IBOutlet var titleField: MDCTextField!
  
  @IBAction func onAddButtonClicked(_ sender: Any) {
    
    var newLovket = Lovket(nil)
    newLovket.title = titleField.text ?? ""
    newLovket.content = subtitleField.text ?? ""
    newLovket.type = type
    newLovket.progress = Lovket.PROGRESS_MY_LOVKET
    
    if newLovket.title.isEmpty || newLovket.content.isEmpty {
      showAlert("error".localize, "lovket-error-empty".localize, true, { _ in })
      return
    }
    
    lovketRepository.addNewLovket(lovket: newLovket, onSuccessCallback: {
      
    }, onErrorCallback: {
      _ in
    })
    
  }
  
  @IBAction func onTypeChangeButtonClicked(_ sender: Any) {
    
    if (type == 5) {
      type = 0
    } else {
      type = type + 1
    }
    
    typeChangeButton.setImage(icons[type], for: UIControlState.normal)
    
    updateImage()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    _ = navigationController?.navigationBar.then {
      $0.backgroundColor = UIColor.clear
      $0.tintColor = UIColor.white
      $0.barStyle = .blackOpaque
      $0.isTranslucent = true;
    }
  }
  
  func updateImage() {
    if !ImageSaver.images.isEmpty {
      let images = ImageSaver.images[keywords[type]]!
      
      UIView.animate(withDuration: 0.5, animations: {
        self.backgroundImageView.alpha = 0.0
      })
      
      backgroundImageView.downloadedFrom(link: images[Int(arc4random_uniform(UInt32(images.count)))], contentMode : .scaleAspectFill) {
        UIView.animate(withDuration: 0.5, animations: {
          self.backgroundImageView.alpha = 1.0
        })
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    self.moveViewWhenKeyboardShowing()
    updateImage()
    
    typeChangeButton.setImage(icons[type], for: UIControlState.normal)
    typeChangeButton.setElevation(ShadowElevation.init(0), for: UIControlState.normal)
    typeChangeButton.setElevation(ShadowElevation.init(2), for: UIControlState.highlighted)
    titleField.font = UIFont(name : titleField.font!.fontName, size: 32)
    subtitleField.font = UIFont(name : titleField.font!.fontName, size: 16)
    _ = titleField.setupLight(self, placeHolderKey: "type-lovket-title")
    _ = subtitleField.setupLight(self, placeHolderKey: "type-lovket-subtitle")
    
  }
  
}
