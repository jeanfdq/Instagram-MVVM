//
//  AuthService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//


import Foundation

class AuthService: NSObject {
    
    static let shared = AuthService()
    fileprivate let instance = FirebaseInstances.auth()
    
    var isUserLogged:Bool {
        return instance.currentUser == nil ? false : true
    }
    
    func getCurrentUserId() -> String? {
        return instance.currentUser?.uid
    }
    
    func createLogin(_ viewModel:SignUpViewModel, completion:@escaping (Result<Void, Error>) ->Void) {
        
        instance.createUser(withEmail: viewModel.email, password: viewModel.password) { (result, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
        
    }
    
    func userLogin(_ viewModel:LoginViewModel, completion:@escaping (Result<Void, Error>) ->Void){
        
        instance.signIn(withEmail: viewModel.email, password: viewModel.password) { (result, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
        
    }
    
    func authEmailExists(_ email:String, completion:@escaping(Bool)->Void){
        instance.fetchSignInMethods(forEmail: email) { (method , error) in
            
            completion(method != nil)
            
        }
    }
    
}
