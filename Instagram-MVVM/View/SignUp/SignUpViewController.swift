//
//  SignUpViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

fileprivate enum typeOfChoosePhoto{
    case library
    case camera
}

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var viewModel = SignUpViewModel()
    
    var pickerView = PickerView()
    
    lazy var profilePhoto:UIButton = {
        let photo = UIButton()
        photo.setImage(UIImage(named: "plus_photo")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
        photo.contentVerticalAlignment = .fill
        photo.contentHorizontalAlignment = .fill
        photo.setCorner(radius: 60)
        
        photo.addTapGesture { [weak self] in
            self?.choosePhoto()
        }
        
        return photo
    }()
    
    lazy var emailField:BindingTextField = {
        let field = BindingTextField()
        field.createFieldWhiteAlpha(placeHolder: "e-mail", keyboard: .emailAddress)
        field.autocapitalizationType = .none
        field.bind { [unowned self] in self.viewModel.email = $0 }
        return field
    }()
    
    lazy var passwordField:BindingTextField = {
        let field = BindingTextField()
        field.createFieldWhiteAlpha(placeHolder: "password", keyboard: .numberPad, isSecurity: true)
        field.bind { [unowned self] in self.viewModel.password = $0 }
        return field
    }()
    
    lazy var fullNameField:BindingTextField = {
        let field = BindingTextField()
        field.createFieldWhiteAlpha(placeHolder: "full name", keyboard: .asciiCapable)
        field.autocapitalizationType = .words
        field.autocorrectionType = .no
        field.bind { [unowned self] in self.viewModel.fullName = $0 }
        return field
    }()
    
    lazy var userNameField:BindingTextField = {
        let field = BindingTextField()
        field.createFieldWhiteAlpha(placeHolder: "user name", keyboard: .asciiCapable)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.bind { [unowned self] in self.viewModel.userName = $0 }
        return field
    }()
    
    lazy var signupButton:UIButton = {
        let btn = UIButton()
        btn.createTransparentButton("Sign Up")
        return btn
    }()
    
    lazy var containerFields:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, fullNameField, userNameField, signupButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        setupView()
        setupConstraintsSubViews()
        
    }
    
    // MARK: - functions
    
    fileprivate func setupDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
        fullNameField.delegate = self
        userNameField.delegate = self
        pickerView.pickerViewDelegate = self
    }
    
    fileprivate func setupView() {
        view.setBackgroundGradientLogin()
        view.addTapGesture {[weak self] in
            self?.view.dismissKeyboard()
        }
    }
    
    fileprivate func setupConstraintsSubViews() {
        view.addSubViews(profilePhoto, containerFields)
        profilePhoto.applyViewConstraints(top: view.topAnchor, centerX: view.centerXAnchor, size: .init(width: 120, height: 120), value: .init(top: 32, left: 0, bottom: 0, right: 0))
        containerFields.applyCenterIntoSuperView(size: .init(width: view.frame.width * 0.8, height: 260))
    }
    
    fileprivate func choosePhoto(){
        let alertChoose = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "camera", style: .default) { [weak self] _ in
            self?.pickerViewControl(type: .camera)
        }
        camera.setTitleColor(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        
        let library = UIAlertAction(title: "library", style: .default) { [weak self] _ in
            self?.pickerViewControl(type: .library)
        }
        library.setTitleColor(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        cancel.setTitleColor(color: .red)
        
        alertChoose.addAction(camera)
        alertChoose.addAction(library)
        alertChoose.addAction(cancel)
        
        self.present(alertChoose, animated: true)
    }
    
    fileprivate func pickerViewControl(type: typeOfChoosePhoto) {
        
        let addPhoto = UIImagePickerController()
        addPhoto.delegate = pickerView
        
        if type == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            addPhoto.sourceType = .camera
        }else{
            addPhoto.sourceType = .photoLibrary
        }
        
        self.present(addPhoto, animated: true, completion: nil)
        
    }
    
}

extension SignUpViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailField: passwordField.becomeFirstResponder()
        case passwordField: fullNameField.becomeFirstResponder()
        case fullNameField: userNameField.becomeFirstResponder()
        default: self.view.dismissKeyboard()
        }
        return true
    }
    
}

extension SignUpViewController:getPhotoFromPickerViewProtocol{
    
    func getPhoto(_ imagePickerView: UIImage) {
        profilePhoto.setImage(imagePickerView, for: .normal)
    }
    
}