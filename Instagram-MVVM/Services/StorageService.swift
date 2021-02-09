//
//  StorageService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

enum storageError: String, Error {
    case convertDataError = "Erro ao converter a imagem."
    case insertImageError = "Erro ao inserir a imagem no storage."
    case getUrlImageError = "Erro ao recuperar url da imagem."
}

class StorageService: NSObject {
    
    static let shared = StorageService()
    fileprivate let instance = FirebaseInstances.storage()
    
    func addPhotoStorage(_ image:UIImage, completion:@escaping(Result<String, storageError>)->Void) {
        
        if let data = image.jpegData(compressionQuality: 0.5), let imageName = AuthService.shared.getCurrentUserId() {
            
            let path = instance.child(PHOTO_PATH_STORAGE).child("\(imageName).jpeg")
            path.putData(data, metadata: nil) { (_ , error) in
                
                if let _ = error {
                    completion(.failure(.insertImageError))
                } else {
                    
                    path.downloadURL { (url, error) in
                        
                        if let _ = error {
                            completion(.failure(.getUrlImageError))
                        } else {
                            
                            guard let urlString = url?.absoluteString else {return}
                            completion(.success(urlString))
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            completion(.failure(.convertDataError))
        }
        instance.child(PHOTO_PATH_STORAGE)
        
    }
    
}
