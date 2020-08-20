//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jaspreet Singh on 20/08/20.
//  Copyright © 2020 Jaspreet Singh. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    private let databaseReference = Database.database().reference()
    
    // MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for email and username availability sucess or failure
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert new user into database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for database entry sucess or failure
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        databaseReference.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            guard error == nil else {
                // failed
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    // MARK : - Private
    
}
