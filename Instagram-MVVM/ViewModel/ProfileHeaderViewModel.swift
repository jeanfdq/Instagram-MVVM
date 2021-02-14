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
    
    var userId:String {
        return user.id
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
    
    var isFollowed:Bool {
        return user.followed ?? false
    }
    
    var profileBtnTitle:String {
        return isCurrentUser ? "Edit Profile" : user.followed ?? false ? "Unfollow" : "Follow"
    }
    
    var profileBtnBackground:UIColor {
        return isCurrentUser ? .clear : .systemBlue
    }
    
    var profileBtnTextColor:UIColor {
        return isCurrentUser ? .darkGray : .white
    }
    
    func fetchFollowing(_ userId:String, completion:@escaping([String])->Void) {
        
        UserService.fetchAllFollowing(userId) { listOfFollowing in
            completion(listOfFollowing)
        }
    }
    
    func fetchFollowers(_ userId:String, completion:@escaping([String])->Void) {
        UserService.fetchAllFollowers(userId) { listOfFollowers in
            completion(listOfFollowers)
        }
    }
    
}
