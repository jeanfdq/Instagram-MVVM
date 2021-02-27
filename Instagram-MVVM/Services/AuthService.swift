//
//  AuthService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//


import Foundation

class AuthService: NSObject {
    
    static let shared = AuthService()
    
    var isUserLogged:Bool {
        return INSTANCE_AUTH.currentUser == nil ? false : true
    }
    
    func getCurrentUserId() -> String? {
        return INSTANCE_AUTH.currentUser?.uid
    }
    
    func createLogin(_ viewModel:SignUpViewModel, completion:@escaping (Result<Void, Error>) ->Void) {
        
        INSTANCE_AUTH.createUser(withEmail: viewModel.email, password: viewModel.password) { (result, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                if let userFIR = result?.user {
                    let changeRequest = userFIR.createProfileChangeRequest()
                    changeRequest.displayName = viewModel.fullName
                    changeRequest.commitChanges { error in
                        
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                        
                    }
                }
                
            }
            
        }
        
    }
    
    func userLogin(_ viewModel:LoginViewModel, completion:@escaping CompletionHandler<Result<Void, Error>>){
        
        INSTANCE_AUTH.signIn(withEmail: viewModel.email, password: viewModel.password) { (result, error) in
            
            if let error = error {
                DefaultsManager.shared().delete(key: .userLoggedData)
                completion(.failure(error))
            } else {
                
                UserService.fetchUser { result in
                    switch result {
                    case .failure(let err): completion(.failure(err))
                    case .success(let user):
                        guard let user = user else { return }
                        DefaultsManager.shared().save(object: user.toData(), key: .userLoggedData)
                        completion(.success(()))
                    }
                }
                
            }
            
        }
        
    }
    
    func authEmailExists(_ email:String, completion:@escaping CompletionHandler<Bool>){
        INSTANCE_AUTH.fetchSignInMethods(forEmail: email) { (method , error) in
            completion(method != nil)
        }
    }
    
    func logout(){
        try? INSTANCE_AUTH.signOut()
    }
    
}
