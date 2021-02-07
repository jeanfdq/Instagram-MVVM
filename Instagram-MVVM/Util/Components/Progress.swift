//
//  Progress.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import JGProgressHUD

class Progress: NSObject {
    
    static func show(_ view:UIView) -> JGProgressHUD{
        let instance = JGProgressHUD()
        instance.textLabel.text = "aguarde..."
        instance.show(in: view, animated: true)
        return instance
    }
    
    static func dismis(_ hud:JGProgressHUD){
        hud.dismiss()
    }
}
