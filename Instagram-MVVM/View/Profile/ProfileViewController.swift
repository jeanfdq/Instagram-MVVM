//
//  ProfileViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class ProfileViewController: UIViewController {

    
    lazy var logoutLabel:UILabel = {
        let logout = UILabel()
        logout.text = "logout"
        logout.font = .systemFont(ofSize: 13, weight: .semibold)
        logout.isUserInteractionEnabled = true
        logout.addTapGesture {
            self.logout()
        }
        return logout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutLabel)
        
    }
    
    @objc fileprivate func logout(){
        let alertLogout = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "logout", style: .default) { _ in
            AuthService.shared.logout()
            NotificationCenter.default.post(name: .NCD_UserLogout, object: nil)
        }
        logoutAction.setTitleColor(color: .red)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        cancelAction.setTitleColor(color: .blue)
        
        alertLogout.addAction(logoutAction)
        alertLogout.addAction(cancelAction)
        
        present(alertLogout, animated: true)
        
        
    }

}
