//
//  ProfileHeaderViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 09/02/21.
//

import Foundation

class ProfileHeaderViewModel: NSObject {
    
    fileprivate var user:User
    
    init(_ user:User) {
        self.user = user
    }
    
    var profileImage:String {
        return user.profileImage
    }
    
    var fullName:String {
        return user.fullName
    }
    
}
