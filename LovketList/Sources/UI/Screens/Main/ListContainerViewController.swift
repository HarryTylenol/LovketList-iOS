//
//  ListContainerViewController.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import RKDropdownAlert
import Then
import SpringIndicator

extension ListContainerViewController: UITableViewDelegate, UITableViewDataSource {
  
  func reloadAtFinalUpdate() {
    self.loadCounter += 1
    if self.loadCounter > 2 {
      UIView.transition(with: self.tableView,
                        duration: 0.35,
                        options: .transitionCrossDissolve,
                        animations: { self.tableView.reloadData() })
      self.refreshControll.endRefreshing()
      self.loadCounter = 0
    }
  }
  
  func updateListData(progress: Int) {
    lovketRepository.queryLovket(progress: progress, onSuccessCallback: {
      self.reloadAtFinalUpdate()
    }, onErrorCallback: { e in
      print(e ?? "NIL")
      self.reloadAtFinalUpdate()
    })
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
    print("\(indexPath.section), \(indexPath.row)")
    return (tableView.dequeueReusableCell(withIdentifier: "lovketCell", for: indexPath) as! LovketListItemCell).then {
      $0.selectionStyle = .none
      
      let documentListPerSection = LovketRepository.documentLists[indexPath.section]
      if !documentListPerSection.isEmpty {
        $0.bindData(lovket: documentListPerSection[indexPath.row].toLovket())
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if (tableView.cellForRow(at: indexPath) is LovketHeaderItemCell) {
      return
    } else {
      print("Selected \(indexPath.row) \(indexPath.section)")
      
      self.performSegue(withIdentifier: "Detail", sender: LovketRepository.documentLists[indexPath.section][indexPath.row].toLovket())
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = LovketRepository.documentLists[section].count
    if count < 3 {
      return count
    }
    else {
      return 3
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    //    let done = LovketRepository.documentLists[Lovket.PROGRESS_DONE]
    //    let notDone = LovketRepository.documentLists[Lovket.PROGRESS_NOT_DONE]
    //    let my = LovketRepository.documentLists[Lovket.PROGRESS_MY_LOVKET]
    //
    //    if done.isEmpty && notDone.isEmpty && my.isEmpty {
    //      return 0
    //    } else if !done.isEmpty && !notDone.isEmpty && !my.isEmpty {
    //      return 3
    //    } else if
    //      !done.isEmpty && notDone.isEmpty && my.isEmpty ||
    //        done.isEmpty && !notDone.isEmpty && my.isEmpty ||
    //        done.isEmpty && notDone.isEmpty && !my.isEmpty {
    //      return 1
    //    } else {
    //      return 2
    //    }
    return 3
  }
  
}

extension ListContainerViewController: UIViewControllerPreviewingDelegate {
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    guard let indexPath = tableView.indexPathForRow(at: location) else {
      return nil
    }
    
    return (self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController).then {
      $0.lovket = LovketRepository.documentLists[indexPath.section][indexPath.row].toLovket()
    }
  }
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    show(viewControllerToCommit, sender: self)
  }
  
}

extension ListContainerViewController: RKDropdownAlertDelegate {
  
  func dropdownAlertWasTapped(_ alert: RKDropdownAlert!) -> Bool {
    return true
  }
  
  func dropdownAlertWasDismissed() -> Bool {
    return true
  }
  
}

class ListContainerViewController: UIViewController {
  
  var loadCounter = 0
  
  @IBAction func onAddButtonClicked(_ sender: Any) {
    
  }
  
  @IBOutlet var tableView: UITableView!
  
  var refreshControll = RefreshIndicator()
  
  var lovketRepository: LovketRepository!
  
  @objc func updateAll() {
    LovketRepository.refreshList()
    loadCounter = 0
    updateListData(progress: Lovket.PROGRESS_DONE)
    updateListData(progress: Lovket.PROGRESS_NOT_DONE)
    updateListData(progress: Lovket.PROGRESS_MY_LOVKET)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refreshControll.indicator.lineColor = self.view.tintColor
    refreshControll.addTarget(self, action: #selector(updateAll), for: UIControlEvents.valueChanged)
    
    tableView.addSubview(refreshControll)
    
    updateAll()
    
    if traitCollection.forceTouchCapability == .available {
      registerForPreviewing(with: self, sourceView: tableView)
    }
    
    RKDropdownAlert.title("", message: "lovket-request".localize,
                          backgroundColor: self.view.tintColor,
                          textColor: UIColor.white, time: 2, delegate: self)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    title = "LOVKETLIST"
    
    _ = navigationController?.navigationBar.then {
      $0.tintColor = UIColor.lightGray
      $0.backgroundColor = UIColor.white
      $0.setBackgroundImage(UIImage(), for: .default)
      $0.shadowImage = UIImage()
      $0.isTranslucent = true;
      $0.titleTextAttributes = [
        NSAttributedStringKey.foregroundColor: self.view.tintColor,
        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
      ]
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName:"ic_menu_18pt"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector((slideMenuController() as! MainViewController).openNavigationDrawer))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName:"ic_notifications_18pt"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector((slideMenuController() as! MainViewController).openNotificationDrawer))
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    _ = navigationController?.navigationBar.then {
      $0.tintColor = UIColor.lightGray
      $0.barStyle = .default
    }
  }
  
  @objc func moveToSeeMoreViewController() {
    performSegue(withIdentifier: "MoreList", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Detail" {
      if let destinationViewController = segue.destination as? DetailViewController {
        destinationViewController.lovket = sender as! Lovket
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}
