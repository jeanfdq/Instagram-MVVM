//
//  SearchUserViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 13/02/21.
//

import Foundation

class SearchUserViewModel: NSObject {
    
    var user:User
    
    init(_ user:User) {
        self.user = user
        super.init()
    }
    
    var userName:String {
        return user.userName
    }
    
    var fullName:String {
        return user.fullName
    }
    
    var photoUrl:String {
        return user.profileImage
    }
    
}
