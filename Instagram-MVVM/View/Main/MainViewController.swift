//
//  MainViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVireControllers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUserLogged), name: .NCD_UserLogout, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyUserLogged()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setupVireControllers() {
        
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.home())
        
        let search = SearchViewController().setTemplateNavigationController(FactoryTabBarIcons.search())
        
        let imageSelector = ImageSelectorViewController().setTemplateNavigationController(FactoryTabBarIcons.imageSelector())
        
        let notification = NotificationsViewController().setTemplateNavigationController(FactoryTabBarIcons.notifications())
        
        let profile = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.profile())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }
    
    @objc fileprivate func verifyUserLogged() {
        DispatchQueue.main.async {
            if !AuthService.shared.isUserLogged {
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .currentContext
                self.present(loginVC, animated: false)
            }
        }
        
    }
    
}
