//
//  NotificationsService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Firebase

class NotificationsService: NSObject {
    
    class func uploadNotification(_ user:User, toUserId userId:String, type:NotificationType, post:Post? = nil ){
        
        var data:[String : Any] = ["userId":user.id, "userProfileUrl":user.profileImage, "type": type.rawValue, "timeStamp":Timestamp(date: Date())]
        
        if let post = post {
            data = ["postId":post.uuid, "postImageUrl":post.imageURL]
        }
        
        COLLECTION_NOTIFICATIONS.document(userId).collection(NOTIFICATIONS_USERS).addDocument(data: data)
    }
    
    class func fetchNotifications(completion:@escaping CompletionHandler<[PostNotification]>) {
        
    }
    
}
