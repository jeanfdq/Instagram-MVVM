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
    
    func createFieldWhiteAlpha(placeHolder:String, keyboard: UIKeyboardType, isSecurity:Bool = false){
        setCorner(radius: 5)
        paddingLeft(value: 12)
        backgroundColor = .init(white: 0.8, alpha: 0.2)
        textColor = .init(white: 1, alpha: 0.7)
        font = .systemFont(ofSize: 16, weight: .semibold)
        keyboardAppearance = .dark
        keyboardType = keyboard
        isSecureTextEntry = isSecurity
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 1, alpha: 0.7)])
    }
    
}
