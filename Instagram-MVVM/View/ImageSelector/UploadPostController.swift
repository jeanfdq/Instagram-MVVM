//
//  UploadPostController.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 21/02/21.
//

import UIKit

class UploadPostController: UIViewController {

    // MARK: - Properties
    
    var user:User?
    
    var selectedImage:UIImage? {
        didSet { previewImageView.image = selectedImage }
    }
    
    private let previewImageView:UIImageView = {
        let piv = UIImageView()
        piv.clipsToBounds = true
        piv.contentMode = .scaleAspectFill
        return piv
    }()
    
    private lazy var captionImage:ImputTextView = {
        let caption = ImputTextView()
        caption.placeHolderText = "Enter caption..."
        caption.font = .systemFont(ofSize: 16, weight: .medium)
        caption.delegate = self
        return caption
    }()
    
    private let countCaption:UILabel = {
        let countCaption = UILabel()
        countCaption.text = "0/100"
        countCaption.font = .systemFont(ofSize: 13, weight: .semibold)
        countCaption.textColor = .lightGray
        return countCaption
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        view.addSubViews(previewImageView, captionImage, countCaption)
        previewImageView.applyViewConstraints(leading: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, size: .init(width: view.frame.width, height: view.frame.height * 0.3), value: .zero)
        captionImage.applyViewConstraints(leading: previewImageView.leadingAnchor, top: previewImageView.bottomAnchor, trailing: previewImageView.trailingAnchor, size: .init(width: 0, height: 60), value: .init(top: 10, left: 10, bottom: 0, right: 0))
        countCaption.applyViewConstraints( top: captionImage.bottomAnchor, trailing: captionImage.trailingAnchor, size: .zero, value: .init(top: 8, left: 0, bottom: 0, right: 8))
    }
    
    // MARK: - functions
    
    fileprivate func configureUI() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem    = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissThisController))
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(self.sharePost))
        
    }
    
    // MARK: - Selectors
    
    @objc fileprivate func sharePost() {

        if captionImage.text.isEmpty {
            self.showLoafError(message: "Informe o caption do post!")
        } else if let selectedImage = selectedImage {
            
            if let user = user {
                
                let progress = showLoading()
                
                DBService.createPost(user, selectedImage, captionImage.text) { [unowned self] result in
                    
                    switch result {
                    case .failure(let error): self.showLoafError(message: error.rawValue)
                    case .success():
                        NotificationCenter.default.post(name: .NCD_UserPosted, object: nil)
                        self.dismiss(animated: false)
                    }
                    progress.dismiss()
                }
                
            } else {
                self.showLoafError(message: "Post sem usuário!")
            }
            
        } else {
            self.showLoafError(message: "Post sem imagem!")
        }
        
        
    }
    
    @objc fileprivate func dismissThisController() {
        self.dismiss(animated: false)
    }

}

extension UploadPostController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        } else {
            countCaption.text = "\(textView.text.count)/100"
        }
    }
    
}
