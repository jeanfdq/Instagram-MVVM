//
//  UIAlertActionExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UIAlertAction {
    
    static func setAction(_ title:String?, _ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
    
    static func setCancel(_ title:String?, _ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel, handler: handler)
    }
    
    static func setTitleColor(color:UIColor){
        self.setValue(color, forKey: "titleTextColor")
    }
}
