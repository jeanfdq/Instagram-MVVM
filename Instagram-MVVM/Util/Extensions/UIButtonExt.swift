//
//  UIButtonExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UIButton {
    
    func setErrorAnime() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.duration = 0.1
        animation.fromValue = CGPoint(x: self.center.x - 5, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 5, y: self.center.y)
        layer.add(animation, forKey: nil)
        
    }
}
