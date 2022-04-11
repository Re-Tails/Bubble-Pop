//
//  Bubble.swift
//  Bubble Pop
//
//  Created by Tien Long Lam on 11/4/2022.
//

import Foundation
import UIKit

class Bubble:UIView {
    
    var xPosition = 0
    var yPosition = 0
    /*
     let window = UIApplication.shared.windows.first
     let topPadding = window.safeAreaInsets.top
     let bottomPadding = window.safeAreaInsets.bottom
     */
    
    init(frame: CGRect, backgroundColor: UIColor) { //CHANGE THIS
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        <#code#>
    }
   
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
}


