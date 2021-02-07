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

        view.backgroundColor = .white
        
        setupVireControllers()
        
        
        
    }
    
    
    fileprivate func setupVireControllers() {
        
        let feed = FeedViewController().setTemplateNavigationController(FactoryTabBarIcons.home())
        
        let search = SearchViewController().setTemplateNavigationController(FactoryTabBarIcons.search())

        let imageSelector = ImageSelectorViewController().setTemplateNavigationController(FactoryTabBarIcons.imageSelector())

        let notification = NotificationsViewController().setTemplateNavigationController(FactoryTabBarIcons.notifications())

        let profile = ProfileViewController().setTemplateNavigationController(FactoryTabBarIcons.profile())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }

}
