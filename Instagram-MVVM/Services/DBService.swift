//
//  DBService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Foundation
import FirebaseFirestore

enum dbError:String, Error {
    case createUserAuthError = "Erro ao criar o login"
    case createUserError = "Erro ao criar o usuário"
    case creteUserEmailError = "E-mail já cadastrado."
    case insertProfilePhotoError = "Erro ao inserir a foto no Storange"
}

class DBService: NSObject {
    
    static func createUser(_ viewModel:SignUpViewModel, completion:@escaping (Result<Void,dbError>)->Void){
        
        
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
                                StorageService.shared.addPhotoStorage(profile) { result in
                                    
                                    switch result {
                                    case .failure(_ ): completion(.failure(.insertProfilePhotoError))
                                    case .success(let imageURL):
                                        
                                        //Vamos gravar o user no Firestore
                                        let userDictionary = viewModel.createdViewmodelDictionary(userId, imageURL)
                                        let instance = FirebaseInstances.db()
                                        instance.collection(USER_COLLECTION).document(userId)
                                            .setData(userDictionary) { (err) in
                                                
                                                if let _ = err {
                                                    completion(.failure(.createUserError)) }
                                                else {
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
            
        } else {
            completion(.failure(.createUserError))
        }
        
    }
}
