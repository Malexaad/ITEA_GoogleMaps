//
//  ButtonExtantion.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/27/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 1
        shake.repeatCount = 3
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 10, y: center.y - 10)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 10, y: center.y + 10)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: nil)
    }
}
