//
//  CurrentUserData.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

class CurrentUserData: NSObject {
    
    class func get() -> User {
        
        let userEmpty = User.empty()
        
        guard let data:Data = DefaultsManager.shared().get(key: .userLoggedData) else {return userEmpty}
        guard let user:User = data.toModel() else {return userEmpty}
        return user
    }
    
}
