//
//  ImageSaver.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 28..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit
import Siesta


class ImageSaver {
  
  static let keywords = ["food", "place", "celebrate", "love", "calendar", "abroad"]
  static var images = [String : [String]]()
  
  class func saveImage() {
    
    // ((resource.jsonDict["hits"] as! [Any])[0] as! [String : Any])["webformatURL"] as! String
    keywords.forEach { keyword in
      Service(baseURL: "https://pixabay.com/api/?key=7204310-88840e1e85133c7cc7f6b2600&image_type=photo&pretty=true&q=\(keyword)").resource("").addObserver(owner: self) {
        resource, _ in
        let data = resource.jsonDict
        if !data.isEmpty {
          ImageSaver.images[keyword] = (data["hits"] as! [Any]).map({ any in
            (any as! [String : Any])["previewURL"] as! String
          })
        }
      }.load()
    }
  }
  
}
