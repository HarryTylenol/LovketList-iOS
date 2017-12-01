//
//  AppDelegate.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 20..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import UserNotifications
import Firebase
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
  
  static var delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
  static var di: DependencyInjector!
  var window: UIWindow?
  var messaging: Messaging!
  var mainViewController: MainViewController!
  var loginViewController: LoginViewController!
  var checkGroupViewController: CheckGroupViewController!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    AppDelegate.di = DependencyInjector.Builder(SwinjectStoryboard.defaultContainer)
      .addModule(module: FirebaseModule())
      .addModule(module: RepositoryModule())
      .addStoryboardModule(storyboardModule: ViewControllerModule())
      .build()
    
    mainViewController = (AppDelegate.di.getViewController("Main") as! MainViewController)
    loginViewController = (AppDelegate.di.getViewController("Login") as! LoginViewController)
    checkGroupViewController = (AppDelegate.di.getViewController("CheckGroup") as! CheckGroupViewController)
    
    registerFCMService(application)
    refreshViewController()
    
    AuthManager.authCallback { _ in
      self.refreshViewController()
    }
    
    ImageSaver.saveImage()
    
    return true
  }
  
  
  func refreshViewController() {
    //      try! Auth.auth().signOut()
    
    if AppDelegate.di.inject(Auth.self).currentUser != nil {
      AuthManager.uid = AppDelegate.di.inject(Auth.self).currentUser?.uid
      let userRepository = AppDelegate.di.inject(UserRepository.self)
      userRepository.queryUser(onUserDataCallback: { user in
        self.loginViewController.dismiss(animated: false, completion: nil)
        if (user == nil) {
          self.window?.rootViewController = self.checkGroupViewController
        } else {
          self.window?.rootViewController = self.mainViewController
        }
      })
    } else {
      self.window?.rootViewController = self.loginViewController
    }
  }
  
  
}

extension AppDelegate {
  
  
  func registerFCMService(_ application: UIApplication) {
    
    messaging = AppDelegate.di.inject(Messaging.self)
    
    messaging.delegate = self
    
    AppDelegate.FCMToken = messaging.fcmToken!
    
    if #available(iOS 10.0, *) {
      // For iOS 10 display notification (sent via APNS)
      UNUserNotificationCenter.current().delegate = self
      
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in })
      
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
  }
  
  static var FCMToken: String = ""
  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    AppDelegate.FCMToken = fcmToken
  }
  
  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print(userInfo)
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("APNs token retrieved: \(deviceToken)")
    messaging.apnsToken = deviceToken
  }
  
  
}

