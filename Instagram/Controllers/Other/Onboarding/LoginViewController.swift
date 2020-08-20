//
//  LoginViewController.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameEmailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New user? Create an account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header =  UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                                      action: #selector(didTapCreateAccountButton),
                                      for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)

        userNameEmailTextField.delegate = self
        passwordTextField.delegate = self
        
        addSubviews()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign Frames
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 3.0)
        
        userNameEmailTextField.frame = CGRect(x: 25,
                                              y: headerView.bottom + 40,
                                              width: view.width - 50,
                                              height: 52)
        
        passwordTextField.frame = CGRect(x: 25,
                                         y: userNameEmailTextField.bottom + 10,
                                         width: view.width - 50,
                                         height: 52)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordTextField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaBottomInset - 100,
                                   width: view.width - 20,
                                   height: 50)
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaBottomInset - 50,
                                     width: view.width - 20,
                                     height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundImageView = headerView.subviews.first else {
            return
        }
        
        backgroundImageView.frame = headerView.bounds
        
        // Add logo
        let imageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4,
                                 y: view.safeAreaTopInset,
                                 width: headerView.width/2,
                                 height: headerView.height - view.safeAreaTopInset)
        
    }
    
    private func addSubviews() {
        view.addSubview(userNameEmailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton )
        view.addSubview(headerView)
    }
}

extension LoginViewController {
    // MARK : - Actions
    @objc private func didTapLoginButton() {
        passwordTextField.resignFirstResponder()
        userNameEmailTextField.resignFirstResponder()
        
        guard let userNameEmail = userNameEmailTextField.text, !userNameEmail.isEmpty, let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        // Login Functionality
        var userName: String?
        var email: String?
        
        if userNameEmail.contains("@"), userNameEmail.contains(".") {
            // email
            userName = userNameEmail
        } else {
            // userName
            email = userNameEmail
        }
        
        AuthManager.shared.loginUser(userName: userName, email: email, password: password) {  [weak self] success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self?.dismiss(animated: true, completion: nil)
                    
                } else {
                    // error occurred
                    let alert = UIAlertController(title: "Log In Error",
                                                  message: "We were unable to log you in.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875?helpref=page_content") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
