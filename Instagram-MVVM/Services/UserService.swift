//
//  UserService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

enum dbError:String, Error {
    case createUserAuthError = "Erro ao criar o login"
    case createUserError = "Erro ao criar o usuário"
    case creteUserEmailError = "E-mail já cadastrado."
    case insertProfilePhotoError = "Erro ao inserir a foto no Storange"
    case insertPostPhotoError = "Erro ao inserir a foto do post no storage"
    case createPostError = "Erro ao criar o post"
}

class UserService: NSObject {
    
    class func createUser(_ viewModel:SignUpViewModel, completion:@escaping CompletionHandler<Result<Void,dbError>>){
        
        
        if let profile = viewModel.profileImage {
            
            //Vamos veririfcar se o e-mail ja existe
            AuthService.shared.authEmailExists(viewModel.email) { isExists in
                
                if isExists {
                    completion(.failure(.creteUserEmailError))
                } else {
                    
                    
                    //Vamos criar a autenticaçao
                    AuthService.shared.createLogin(viewModel) { result in
                        
                        switch result {
                        case .failure(_ ): completion(.failure(.createUserAuthError))
                        case .success():
                            
                            if let userId = AuthService.shared.getCurrentUserId() {
                                
                                //Primeiro vamos inserir a foto no storage
                                StorageService.shared.addPhotoStorage(profile, PROFILE_PHOTO_PATH_STORAGE) { result in
                                    
                                    switch result {
                                    case .failure(_ ): completion(.failure(.insertProfilePhotoError))
                                    case .success(let imageURL):
                                        
                                        //Vamos gravar o user no Firestore
                                        let userDictionary = viewModel.createdViewmodelDictionary(userId, imageURL)
                                        
                                        COLLECTION_USERS.document(userId)
                                            .setData(userDictionary) { (err) in
                                                
                                                if let _ = err {
                                                    completion(.failure(.createUserError))
                                                }
                                                else {
                                                    
                                                    COLLECTION_USERS.document(userId).setData(["userSearch" : viewModel.fulltextSearchFields], merge: true) { error in
                                                        
                                                        if let _ = error {
                                                            completion(.failure(.createUserError))
                                                            
                                                        } else {
                                                            
                                                            let user = User(id: userId, profileImage: imageURL, email: viewModel.email, fullName: viewModel.fullName, userName: viewModel.userName, userSearch: viewModel.fulltextSearchFields)
                                                            
                                                            DefaultsManager.shared().save(object: user.toData(), key: .userLoggedData)
                                                            
                                                            completion(.success(()))
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            completion(.failure(.createUserError))
        }
        
    }
    
    class func fetchUser(_ userId:String = AuthService.shared.getCurrentUserId() ?? "", completion:@escaping CompletionHandler<Result<User?,Error>>) {
            
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
    
    class func fetchAllUsers(completion:@escaping(Result<[User],Error>)->Void) {
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                guard let userId = AuthService.shared.getCurrentUserId() else {return}
                guard let snapshot = snapshot else {return}
                
                let listOfUsers = snapshot.documents.map { User.dictionaryToModel(dictionary: $0.data()) }
                let listOfUserWithoutCurrentUser = listOfUsers.filter { $0.id != userId}
                completion(.success(listOfUserWithoutCurrentUser))
                
            }
            
        }
        
    }
    
    class func follow(_ uuid:String, completion:@escaping(Result<Void,Error>)->Void){
        
        let currentUser = CurrentUserData.get()
        
        COLLECTION_FOLLOWING.document(currentUser.id).collection(COLLECTION_USER_FOLLOWING).document(uuid).setData([:]) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                COLLECTION_FOLLOWERS.document(uuid).collection(COLLECTION_USER_FOLLOWERS).document(currentUser.id).setData([:]) { error in
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        
                        NotificationsService.uploadNotification(currentUser, toUserId: uuid, type: .follow)
                        
                        completion(.success(()))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    class func unfollow(_ uuid:String, completion:@escaping(Result<Void,Error>)->Void){
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
    
    class func fetchUserStats(_ userId:String, completion:@escaping(UserStats)->Void){
        
        COLLECTION_FOLLOWING.document(userId).collection(COLLECTION_USER_FOLLOWING).getDocuments { (snapshot, error) in
            
            let following = snapshot?.documents.compactMap{ $0.documentID }.count ?? 0
            
            COLLECTION_FOLLOWERS.document(userId).collection(COLLECTION_USER_FOLLOWERS).getDocuments { (snapshot, error) in

                let followers = snapshot?.documents.compactMap{ $0.documentID }.count ?? 0
                
                PostService.fetchPosts(withUser: userId) { posts in
                    
                    completion( UserStats(followers: followers, following: following, posts: posts.count))
                    
                }
                
            }
            
        }
        
    }
    
    class func checkIfUserIsFollowed(_ userId:String, completion:@escaping(Bool)->Void) {
        
        guard let currentUserId = AuthService.shared.getCurrentUserId() else {return}
        COLLECTION_FOLLOWING.document(currentUserId).collection(COLLECTION_USER_FOLLOWING).document(userId).getDocument { (snapshot, error) in
            
            let isFollowed = snapshot?.exists ?? false
            completion(isFollowed)
            
        }
        
        
    }
    
}
