//
//  UIViewContronllerExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

extension UIViewController {
    
    typealias tupleImages = (UIImage?,UIImage?)
    
    func setTemplateNavigationController(_ tupleImages:tupleImages) -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.tabBarItem.image = tupleImages.0?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = tupleImages.1?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        return nav
    }
    
}
