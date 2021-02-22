//
//  ImageSelectorViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import YPImagePicker

class ImageSelectorViewController: UIViewController {

    fileprivate var user:User
    
    init( _ user: User ) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    fileprivate func didFinishPickingMedia(_ picker:YPImagePicker){
        
        picker.didFinishPicking { (items, _) in
            
            picker.dismiss(animated: false) {
                
                guard let selectedImage = items.singlePhoto?.image else {
                    NotificationCenter.default.post(name: .NCD_UserPosted, object: nil)
                    return
                }
                
                let uploadVC = UploadPostController()
                uploadVC.user = self.user
                uploadVC.selectedImage = selectedImage
                let nav = UINavigationController(rootViewController: uploadVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
                
            }
            
        }
        
    }

}
