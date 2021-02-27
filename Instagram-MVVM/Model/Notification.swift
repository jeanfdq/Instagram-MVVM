//
//  Notification.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Firebase

enum NotificationType : Int {
    case like
    case follow
    case comment
    
    var notificationMessage:String {
        switch self {
        case .like: return " liked your post."
        case .comment: return " commented on your post."
        case .follow: return " started following you."
        }
    }
}

struct Notification {
    let id:String
    let uid:String
    let postImageUrl:String?
    let postId:String?
    let type:NotificationType
    let timeStamp:Timestamp
    
    init(_ dicitionary:[String:Any]) {
        
        self.id = dicitionary["id"] as? String ?? ""
        self.uid    = dicitionary["uid"] as? String ?? ""
        self.postImageUrl   = dicitionary["postImageUrl"] as? String ?? ""
        self.postId         = dicitionary["postId"] as? String ?? ""
        self.type           = NotificationType(rawValue: dicitionary["type"] as? Int ?? 0) ?? .like
        self.timeStamp      = dicitionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
