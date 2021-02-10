//
//  LoginViewController.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    fileprivate var viewModel = LoginViewModel()
    
    let viewsHeight:CGFloat = 50
    
    let logoContainer:UIView = {
        let container = UIView()
        let logo = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        container.addSubview(logo)
        logo.applyViewConstraints( centerX: container.centerXAnchor, centerY: container.centerYAnchor)
        return container
    }()
    
    lazy var emailField:BindingTextField = {
        let email = BindingTextField()
        email.createFieldWhiteAlpha(placeHolder: "e-mail", keyboard: .emailAddress)
        email.autocapitalizationType = .none
        email.bind { [unowned self] in self.viewModel.email = $0 }
        return email
    }()
    
    lazy var passwordField:BindingTextField = {
        let password = BindingTextField()
        password.createFieldWhiteAlpha(placeHolder: "password", keyboard: .numberPad, isSecurity: true)
        password.bind { [unowned self] in self.viewModel.password = $0 }
        return password
    }()
    
    lazy var loginButton:UIButton = {
        let btn = UIButton()
        btn.createTransparentButton("Log In")
        btn.addTapGesture { [weak self] in
            self?.login()
        }
        return btn
    }()
    
    let forgotPasswordLabel:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.text = "Forgot your password?"
        label.textColor = .init(white: 0.8, alpha: 0.6)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var signupLabel:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.setTitleAttributeswith(firstTitle: "Don't have an account? ", firstColor: .init(white: 0.7, alpha: 0.7), sizeFirstFont: 14, isfirsBold: false, secondTitle: "Sign Up", secondColor: .init(white: 0.8, alpha: 0.7), sizeSecondFont: 15, isSecondBold: true)
        
        // call signup screen
        label.addTapGesture { [weak self] in
            let signupVC = SignUpViewController()
            signupVC.modalTransitionStyle = .coverVertical
            self?.present(signupVC, animated: true)
        }
        
        return label
    }()
    
    lazy var containerViews:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logoContainer, UIView(), emailField, passwordField, loginButton, forgotPasswordLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraintsSubViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - functions
    
    fileprivate func setupView() {
        view.setBackgroundGradientLogin()
        view.addTapGesture { [weak self] in
            self?.view.dismissKeyboard()
        }
    }
    
    fileprivate func setupConstraintsSubViews() {
        view.addSubViews(containerViews, signupLabel)
        
        containerViews.applyCenterIntoSuperView(size: .init(width: view.frame.width * 0.8, height: 300))
        signupLabel.applyViewConstraints( bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, value: .init(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    fileprivate func login() {
        
        if viewModel.validateFields() {
            
            let progress = self.showLoading()
            
            viewModel.doLogin { [weak self] isLogged in
                
                if isLogged {
                    self?.dismissToRoot()
                } else {
                    self?.showLoafError(message: "Usuário/Senha inválido.")
                }
                
                progress.dismiss()
                self?.dismissToRoot()
            }
        } else {
            loginButton.setErrorAnime()
        }
        
    }

}
