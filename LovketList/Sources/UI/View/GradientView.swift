//
//  GradientView.swift
//  LovketList
//
//  Created by 박현기 on 2017. 11. 27..
//  Copyright © 2017년 박현기. All rights reserved.
//

import UIKit

class GradientView: UIView {
  
  @IBInspectable var startColor: UIColor = .red
  @IBInspectable var endColor: UIColor = .green
  
  override func draw(_ rect: CGRect) {
    
    // 2
    let context = UIGraphicsGetCurrentContext()!
    let colors = [startColor.cgColor, endColor.cgColor]
    
    // 3
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    // 4
    let colorLocations: [CGFloat] = [0.0, 1.0]
    
    // 5
    let gradient = CGGradient(colorsSpace: colorSpace,
                              colors: colors as CFArray,
                              locations: colorLocations)!
    
    // 6
    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x: bounds.width, y: bounds.height)
    context.drawLinearGradient(gradient,
                               start: startPoint,
                               end: endPoint,
                               options: [])
  }
  
}
