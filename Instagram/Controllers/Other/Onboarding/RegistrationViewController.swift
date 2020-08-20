//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
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
        field.placeholder = "Password..."
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        userNameField.delegate = self
        emailField.delegate = self
        passwordTextField.delegate = self

        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        addSubviews()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add frames
        userNameField.frame = CGRect(x: 20, y: view.safeAreaTopInset + 100, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: userNameField.bottom + 10, width: view.width - 40, height: 52)
        passwordTextField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordTextField.bottom + 10, width: view.width - 40, height: 52)

    }
    
    private func addSubviews() {
        view.addSubview(emailField)
        view.addSubview(userNameField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
    }
    
}

extension RegistrationViewController {
    
    // MARK : - Actions
    
    @objc private func didTapRegister() {
        passwordTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

        guard let email = emailField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty, password.count >= 8,
            let username = userNameField.text, !username.isEmpty else {
                return
        }
        
        AuthManager.shared.registerNewUser(userName: username, email: email, password: password) { [weak self] registered in
            guard registered == true else {
                // failed to register new user
                // show alert
                DispatchQueue.main.async {
                    // error occurred
                    let alert = UIAlertController(title: "Registration Error",
                                                  message: "We were unable to create you new account.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self?.present(alert, animated: true)
                }
                return
            }
            
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        
        return true
    }
    
}
