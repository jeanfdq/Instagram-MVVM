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
            
            COLLECTION_USERS.document(userId)
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
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                guard let userId = AuthService.shared.getCurrentUserId() else {return}
                guard let snapshot = snapshot else {return}
                
                let listOfUsers = snapshot.documents.map { User.dictionaryToModel(dictionary: $0.data()) }
                var listOfUserWithoutCurrentUser = listOfUsers.filter { $0.id != userId}

                self.fetchAllFollowing(userId) { listOfFollowing in
                    
                    
                    for index in (0 ..< listOfUserWithoutCurrentUser.count) {
                        listOfUserWithoutCurrentUser[index].followed = listOfFollowing.contains(listOfUserWithoutCurrentUser[index].id)
                    }
                    
                    completion(.success(listOfUserWithoutCurrentUser))
                    
                }
                
            }
            
        }
        
    }
    
    static func follow(_ uuid:String, completion:@escaping(Result<Void,Error>)->Void){
        
        guard let currentUserId = AuthService.shared.getCurrentUserId() else {return}
        COLLECTION_FOLLOWING.document(currentUserId).collection(COLLECTION_USER_FOLLOWING).document(uuid).setData([:]) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                COLLECTION_FOLLOWERS.document(uuid).collection(COLLECTION_USER_FOLLOWERS).document(currentUserId).setData([:]) { error in
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    static func unfollow(_ uuid:String, completion:@escaping(Result<Void,Error>)->Void){
        guard let currentUserId = AuthService.shared.getCurrentUserId() else {return}
        COLLECTION_FOLLOWING.document(currentUserId).collection(COLLECTION_USER_FOLLOWING).document(uuid).delete { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                COLLECTION_FOLLOWERS.document(uuid).collection(COLLECTION_USER_FOLLOWERS).document(currentUserId).delete { error in
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    static func fetchAllFollowing(_ userId:String, completion:@escaping([String])->Void) {
        
        COLLECTION_FOLLOWING.document(userId).collection(COLLECTION_USER_FOLLOWING).getDocuments { (snapshot, error) in
            
            var listUserId = [String]()
            
            if let snapshot = snapshot {
                listUserId = snapshot.documents.compactMap{ $0.documentID }
            }
            completion(listUserId)
            
        }
    }
    
    static func fetchAllFollowers(_ userId:String, completion:@escaping([String])->Void) {
        
        COLLECTION_FOLLOWERS.document(userId).collection(COLLECTION_USER_FOLLOWERS).getDocuments { (snapshot, error) in
            var listUserId = [String]()
            
            if let snapshot = snapshot {
                listUserId = snapshot.documents.compactMap{ $0.documentID }
            }
            completion(listUserId)
        }
    }
    
}
