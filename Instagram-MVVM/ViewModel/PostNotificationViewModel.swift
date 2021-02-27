//
//  PostNotificationViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

class PostNotificationViewModel: NSObject {
    
    fileprivate var postNotification:PostNotification
    
    init(_ posNotification:PostNotification) {
        self.postNotification = posNotification
        super.init()
    }
    
    var userProfileUrl:URL? {
        return URL(string: postNotification.userProfileUrl)
    }
    
    var userName:String {
        return postNotification.userName
    }
    
    var typeNotification:String {
        return postNotification.type.notificationMessage
    }
    
    var postImageUrl:URL? {
        return URL(string: postNotification.postImageUrl ?? "")
    }
    
}
