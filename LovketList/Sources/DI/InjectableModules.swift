//
//  InjectableModules.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 30..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import Swinject
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging

class FirebaseModule : Module {
  func build(container: Container) {
    container.register(Auth.self) { _ in
      Auth.auth()
    }
    container.register(Firestore.self) { _ in
      Firestore.firestore()
    }
    container.register(Messaging.self) { _ in
      Messaging.messaging()
    }
  }
  
}

class RepositoryModule : Module {
  
  func build(container: Container) {
    container.register(UserRepository.self) {
      UserRepository(firestore : $0.resolve(Firestore.self)!)
    }
    container.register(GroupRepository.self) {
      GroupRepository(firestore : $0.resolve(Firestore.self)!)
    }
    container.register(LovketRepository.self) {
      LovketRepository(firestore : $0.resolve(Firestore.self)!)
    }
    
  }
  
}
