//
//  DependencyInjector.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 21..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

// 
class DependencyInjector {

  var container : Container? = nil
  
  class Builder {
  
    var container : Container
    
    init(_ container : Container) {
      self.container = container
    }
    
    let dependencyInjector = DependencyInjector()
    
    public func addStoryboardModule(storyboardModule : StoryboardModule) -> DependencyInjector.Builder {
      storyboardModule.build(container: container)
      return self
    }
    
    public func addModule(module : Module) -> DependencyInjector.Builder {
      module.build(container : container)
      return self
    }
    
    public func build() -> DependencyInjector {
      dependencyInjector.container = container
      return dependencyInjector
    }
    
  }
  
  func inject<Service>(_ type : Service.Type) -> Service {
    return container!.resolve(type)!
  }
  
  func getViewController<T : UIViewController>(_ identifier : String) -> T {
    let sb = SwinjectStoryboard.create(name: "Main", bundle: nil, container: SwinjectStoryboard.defaultContainer)
    return sb.instantiateViewController(withIdentifier: identifier) as! T
  }
  
}
