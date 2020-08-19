//
//  LoginViewController.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let userNameEmailTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
       return UIButton()
    }()
    
    private let termsButton: UIButton = {
       return UIButton()
    }()
    
    private let privacyButton: UIButton = {
       return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
       return UIButton()
    }()
    
    private let headerView: UIView = {
       return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign Frames
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
    
    @objc func didTapLoginButton() { }
    
    @objc func didTapTermsButton() { }
    
    @objc func didTapPrivacyButton() { }
    
    @objc func didTapCreateAccountButton() { }
}
