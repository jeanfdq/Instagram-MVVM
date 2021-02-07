//
//  FactoryTabBarIcons.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class FactoryTabBarIcons: NSObject {
    
    static func home() -> (UIImage? , UIImage?) {
        return (UIImage(named: "home_unselected"), UIImage(named: "home_selected"))
    }
    
    static func search() -> (UIImage? , UIImage?) {
        return (UIImage(named: "search_unselected"), UIImage(named: "search_selected"))
    }
    
    static func imageSelector() -> (UIImage? , UIImage?) {
        return (UIImage(named: "plus_unselected"), UIImage(named: "plus_selected"))
    }
    
    static func notifications() -> (UIImage? , UIImage?) {
        return (UIImage(named: "like_unselected"), UIImage(named: "like_selected"))
    }
    
    static func profile() -> (UIImage? , UIImage?) {
        return (UIImage(named: "profile_unselected"), UIImage(named: "profile_selected"))
    }
}
