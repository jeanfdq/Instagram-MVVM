//
//  MainViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUserLogged), name: .NCD_UserLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userPostedAndToFeed), name: .NCD_UserPosted, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyUserLogged()
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    fileprivate func setupViewControllers() {
        
        guard let user = self.user else {return}
        
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.home())
        
        let search = SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.search())
        
        let imageSelector = ImageSelectorViewController(user).setTemplateNavigationController(FactoryTabBarIcons.imageSelector())
        
        let notification = NotificationsViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.notifications())
        
        let profile = ProfileViewController(user).setTemplateNavigationController(FactoryTabBarIcons.profile())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
    }
    
    @objc fileprivate func verifyUserLogged() {
  
        DispatchQueue.main.async {[weak self] in
            if !AuthService.shared.isUserLogged {
                
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .currentContext
                self?.present(loginVC, animated: false)
                self?.selectedIndex = 0
                
            } else {
                self?.fetchUser()
            }
        }
    }
    
    fileprivate func fetchUser() {
        
        let progress = Progress.show(view)
      
        DispatchQueue.main.async {
            UserService.fetchUser { [weak self] (result) in
                switch result {
                case .failure(let err):
                    self?.showLoafError(message: err.localizedDescription)

                case .success(let user):
                    self?.user = user
                    self?.setupViewControllers()
                }
                progress.dismiss()
            }
        }
    }
    
    @objc fileprivate func userPostedAndToFeed(){
        selectedIndex = 0
    }
    
}
