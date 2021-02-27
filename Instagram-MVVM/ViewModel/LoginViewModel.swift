//
//  LoginViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Foundation

struct LoginViewModel {
    var email:String = ""
    var password:String = ""
    
    func validateFields() -> Bool {
        if !email.isValidEmail || password.count < 6 {
            return false
        }
        return true
    }
    
    func doLogin(completion:@escaping CompletionHandler<Result<Void, Error>>) {
        AuthService.shared.userLogin(self, completion: completion)
    }
    
    func doLogout() {
        AuthService.shared.logout()
    }
}
