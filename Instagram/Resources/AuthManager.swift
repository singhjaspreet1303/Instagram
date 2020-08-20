//
//  AuthManager.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    // MARK: - Public
    
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: userName) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil, authResult != nil else {
                        // Firebase auth was unable to create new account
                        completion(false)
                        return
                    }
                    
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: userName) { inserted in
                        guard inserted == true else {
                            // failed to insert into database
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                    
                }
            } else {
                // either username or email is not available to create new account
                completion(false)
            }
        }
    }
    
    public func loginUser(userName: String?, email: String? , password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let userName = userName {
             // username log in
            print(userName)
        }
    }
    
}
