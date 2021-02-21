//
//  MainViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import YPImagePicker

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyUserLogged), name: .NCD_UserLogout, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyUserLogged()
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    fileprivate func setupViewControllers(with user:User) {
        
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.home())
        
        let search = SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()).setTemplateNavigationController(FactoryTabBarIcons.search())
        
        let imageSelector = ImageSelectorViewController().setTemplateNavigationController(FactoryTabBarIcons.imageSelector())
        
        let notification = NotificationsViewController().setTemplateNavigationController(FactoryTabBarIcons.notifications())
        
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
                    guard let user = user else {return}
                    self?.setupViewControllers(with: user)
                }
                progress.dismiss()
            }
        }
    }
    
}

extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let viewControllerIndex = viewControllers?.firstIndex(of: viewController)
        
        if viewControllerIndex == 2 { // selector Images to post
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: false)
            self.didFinishPickingMedia(picker)
            
        }
        return true
    }
    
}

extension MainViewController {
    
    fileprivate func didFinishPickingMedia(_ picker:YPImagePicker){
        
        picker.didFinishPicking { (items, _) in
            
            picker.dismiss(animated: false) {
                
                guard let selectedImage = items.singlePhoto?.image else {return}
                
                let uploadVC = UploadPostController()
                uploadVC.previewImageView.image = selectedImage
                let nav = UINavigationController(rootViewController: uploadVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
                
                
            }
            
        }
        
    }
}
