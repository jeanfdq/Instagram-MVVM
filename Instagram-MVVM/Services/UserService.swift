//
//  UserService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

class UserService: NSObject {
    
    //Singleton
    static let shared = UserService()
    
    // MARK: - Properties
    fileprivate let instanceDB = FirebaseInstances.db()
    
    func fetchUser(completion:@escaping(Result<User?,Error>)->Void) {
        if let userId = AuthService.shared.getCurrentUserId() {
            
            instanceDB.collection(USER_COLLECTION).document(userId)
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
    
}
