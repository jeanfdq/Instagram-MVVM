//
//  UserService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

class UserService: NSObject {
    
    // MARK: - Properties
    
    static func fetchUser(completion:@escaping(Result<User?,Error>)->Void) {
        if let userId = AuthService.shared.getCurrentUserId() {
            
            USER_COLLECTION.document(userId)
                .getDocument { (snapshot, error) in
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        
                        let model:User? = snapshot?.data()?.toData()?.toModel()
                        completion(.success(model))
                        
                    }
                    
                }
        }
        
    }
    
    static func fetchAllUsers(completion:@escaping(Result<[User],Error>)->Void) {
        
        USER_COLLECTION.getDocuments { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                guard let userId = AuthService.shared.getCurrentUserId() else {return}
                guard let snapshot = snapshot else {return}
                
                let listOfUsers = snapshot.documents.map { User.dictionaryToModel(dictionary: $0.data()) }
                let listOfUserWithoutMe = listOfUsers.filter { $0.id != userId}
                completion(.success(listOfUserWithoutMe))
                
            }
            
        }
        
    }
    
}
