//
//  ProfileHeaderViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 09/02/21.
//

import UIKit

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
    
    var isCurrentUser:Bool {
        return AuthService.shared.getCurrentUserId() == user.id
    }
    
    var profileBtnTitle:String {
        return isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    var profileBtnBackground:UIColor {
        return isCurrentUser ? .clear : .systemBlue
    }
    
    var profileBtnTextColor:UIColor {
        return isCurrentUser ? .darkGray : .white
    }
    
}
