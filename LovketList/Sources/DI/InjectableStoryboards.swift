//
//  InjectableStoryboards.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

class ViewControllerModule : StoryboardModule {
  
  func build(container: Container) {
    
    container.storyboardInitCompleted(LoginViewController.self) { resolver, controller  in
      
    }
    
    container.storyboardInitCompleted(NavigationDrawerViewController.self) { resolver, controller  in
      
    }
    
    container.storyboardInitCompleted(ListContainerViewController.self) { resolver, controller  in
      controller.lovketRepository = resolver.resolve(LovketRepository.self)
    }
    
    container.storyboardInitCompleted(CheckGroupViewController.self) { resolver, controller  in
      
      controller.groupRepository = resolver.resolve(GroupRepository.self)
      controller.userRepository = resolver.resolve(UserRepository.self)
      
    }
    
    container.storyboardInitCompleted(MainViewController.self) { resolver, controller  in
      
    }
    
  }
  
}
