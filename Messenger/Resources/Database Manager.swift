//
//  Database Manager.swift
//  Messenger
//
//  Created by Milos Tomic on 16/01/2021.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Management

extension DataBaseManager {
    
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observe(.value, with: { snapshot in
            
            guard snapshot.value as? String != nil else {
                
                completion(false)
                return
            }
            
            completion(true)
        })
        
        
    }
    
    
    /// insert new user to database
    public func insertUser(with user: ChatAppUser) {
        
        database.child(user.safeEmail).setValue([
            
            "first_Name": user.firstName,
            "last_Name": user.lastName
            
        ])
    }
    
}
    
    struct ChatAppUser {
        let firstName: String
        let lastName: String
        let emailaddress: String
        //let profilePictureURL: String
        
        var safeEmail: String {
            
            var safeEmail = emailaddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
    }




