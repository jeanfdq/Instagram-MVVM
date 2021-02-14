//
//  SignUpViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import UIKit

struct SignUpViewModel {
    
    var profileImage:UIImage?
    var email:String = ""
    var password:String = ""
    var fullName:String = ""
    var userName:String = ""
    var userSearch:String = ""
    
    
    func validateFields() -> Bool {
        var isValidate = true
        
        if let _ = profileImage {
            
            if password.count < 6 || fullName.count <= 3 || userName.count < 3 {
                isValidate = false
            }
            
        } else {
            isValidate = false
        }
        
        return isValidate
    }
    
    var fulltextSearchFields:String {
        return "\(self.email)-\(self.fullName)-\(self.userName)"
    }
    
    func createdViewmodelDictionary(_ userId:String, _ profileImageUrl:String) -> [String:Any] {
     
        let dictionary:[String:Any] = ["id": userId, "fullName":self.fullName, "userName":self.userName, "email":self.email, "profileImage":profileImageUrl, "userSearch":userSearch]
        return dictionary
        
    }
    
    func createUser( completion:@escaping(Result<Void,dbError>)->Void){
        
        DBService.createUser(self) { result in
            
            switch result {
            case .failure(let error): completion(.failure(error))
            case .success(): completion(.success(()))
            }
            
        }
        
    }
    
}
