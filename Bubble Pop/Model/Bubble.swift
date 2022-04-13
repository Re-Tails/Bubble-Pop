//
//  Bubble.swift
//  Bubble Pop
//
//  Created by Tien Long Lam on 11/4/2022.
//

import Foundation
import UIKit

class Bubble:UIView {
    
    init(backgroundColor: UIColor, frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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


