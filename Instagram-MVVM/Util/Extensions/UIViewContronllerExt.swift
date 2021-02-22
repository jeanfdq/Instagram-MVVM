//
//  UIViewContronllerExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Loaf
import JGProgressHUD

extension UIViewController {
    
    typealias tupleImages = (UIImage?,UIImage?)
    
    func setTemplateNavigationController(_ tupleImages:tupleImages) -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.tabBarItem.image = tupleImages.0?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = tupleImages.1?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        return nav
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    func showAlertSingle(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissToRoot(){
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
    }
    
    func showLoaf(message: String, state: Loaf.State, duration:Double = 1.0 ){
        Loaf(message, state: state, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show(.custom(duration))
    }
    
    func showLoafError(message: String, duration:Double = 2.0 ){
        Loaf(message, state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show(.custom(duration))
    }
    
    func showLoading() -> JGProgressHUD{
        view.endEditing(true)
        let progress = JGProgressHUD(style: .dark)
        progress.textLabel.text = "aguarde..."
        progress.show(in: self.view, animated: true)
        return progress
    }
    
}
