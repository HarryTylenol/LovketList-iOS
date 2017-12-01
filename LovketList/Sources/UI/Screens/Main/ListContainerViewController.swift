//
//  ListContainerViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import RKDropdownAlert

class ListContainerViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, RKDropdownAlertDelegate, UIViewControllerPreviewingDelegate {
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    guard let indexPath = tableView.indexPathForRow(at: location) else {
      return nil
    }
    
    let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
    
    switch indexPath.section {
    case 0:
      detailViewController.lovket = doneList[indexPath.row]
    case 1:
      detailViewController.lovket = notDoneList[indexPath.row]
    case 2:
      detailViewController.lovket = deniedList[indexPath.row]
    default:
      detailViewController.lovket = doneList[indexPath.row]
    }
    
    return detailViewController
  }
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    show(viewControllerToCommit, sender: self)
  }
  
  func dropdownAlertWasTapped(_ alert: RKDropdownAlert!) -> Bool {
    return true
  }
  
  func dropdownAlertWasDismissed() -> Bool {
    UIApplication.shared.statusBarStyle = .default
    return true
  }
  
  @IBAction func onAddButtonClicked(_ sender: Any) {
    
  }
  
  var lovketRepository : LovketRepository? = nil {
    didSet  {
      lovketRepository?.queryOnlyFiveLovket(progress: "", groupKey: "", queryCallback: { lovketList in
        
      })
    }
  }
  
  @IBOutlet var tableView: UITableView!
  
  let doneList = DummyData.doneList
  
  let notDoneList = DummyData.notDoneList
  
  let deniedList = DummyData.deniedList
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if traitCollection.forceTouchCapability == .available {
      registerForPreviewing(with: self, sourceView: tableView)
    }
    
    RKDropdownAlert.title("", message: "새로운 럽킷 요청사항이 있습니다.", backgroundColor: self.view.tintColor, textColor: UIColor.white, time: 3, delegate : self)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    title = "LOVKETLIST"
    
    navigationController?.navigationBar.tintColor = UIColor.lightGray
    navigationController?.navigationBar.backgroundColor = UIColor.clear
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true;
    
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor : self.view.tintColor,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
    ]
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_18pt"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector((slideMenuController() as! MainViewController).openNavigationDrawer))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_notifications_18pt"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector((slideMenuController() as! MainViewController).openNotificationDrawer))
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.navigationBar.tintColor = UIColor.lightGray
    navigationController?.navigationBar.barStyle = .default
  }
  
  @objc func moveToSeeMoreViewController() {
    performSegue(withIdentifier: "MoreList", sender: self)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return (tableView.dequeueReusableCell(withIdentifier: "header") as! LovketHeaderItemCell).then {
      $0.bindData(position: section)
      $0.seeMoreButton.addTarget(self, action: #selector(moveToSeeMoreViewController), for: .touchUpInside)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if section == 2 {
      return 96
    } else {
      return 18
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return (tableView.dequeueReusableCell(withIdentifier: "lovketCell", for: indexPath) as! LovketListItemCell).then {
      $0.selectionStyle = .none
      switch indexPath.section {
      case 0:
        $0.bindData(lovket: doneList[indexPath.row])
      case 1:
        $0.bindData(lovket: notDoneList[indexPath.row])
      case 2:
        $0.bindData(lovket: deniedList[indexPath.row])
      default:
        $0.bindData(lovket: doneList[indexPath.row])
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
  }
  
  // Selected
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    if (tableView.cellForRow(at: indexPath) is LovketHeaderItemCell) {
      return
    } else {
      print("Selected \(indexPath.row) \(indexPath.section)")
      
      var selectedLovket : Lovket!
      switch indexPath.section {
      case 0:
        selectedLovket = doneList[indexPath.row]
      case 1:
        selectedLovket = notDoneList[indexPath.row]
      case 2:
        selectedLovket = deniedList[indexPath.row]
      default:
        selectedLovket = doneList[indexPath.row]
      }
      
      self.performSegue(withIdentifier: "Detail", sender: selectedLovket)
    }
    //  self.present(self.storyboard!.instantiateViewController(withIdentifier: "MoreList"), animated: true, completion: nil)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Detail" {
      if let destinationVC = segue.destination as? DetailViewController {
        destinationVC.lovket = sender as! Lovket
      }
    }
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section {
    case 0: return doneList.count
    case 1: return notDoneList.count
    case 2: return deniedList.count
    default: return 0
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if doneList.isEmpty && notDoneList.isEmpty && deniedList.isEmpty {
      return 0
    } else if !doneList.isEmpty && !notDoneList.isEmpty && !deniedList.isEmpty {
      return 3
    } else if
      !doneList.isEmpty && notDoneList.isEmpty && deniedList.isEmpty ||
        doneList.isEmpty && !notDoneList.isEmpty && deniedList.isEmpty ||
        doneList.isEmpty && notDoneList.isEmpty && !deniedList.isEmpty {
      return 1
    }else {
      return 2
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}
