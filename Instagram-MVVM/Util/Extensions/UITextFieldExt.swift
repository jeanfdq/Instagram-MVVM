//
//  UITextFieldExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UITextField {
    
    func paddingLeft(value:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func paddingRight(value:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func changeColorBorder(isOn: Bool) {
        if isOn {
            self.layer.cornerRadius = 4
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.masksToBounds = true
        }else{
            self.layer.borderWidth = 0
        }
    }
    
}
