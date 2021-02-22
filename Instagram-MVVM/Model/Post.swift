//
//  Post.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 21/02/21.
//

import Firebase

struct Post {
    
    let uuid:String
    let ownerId:String
    let ownerUserName:String
    let ownerProfileUrl:String
    let caption:String
    let imageURL:String
    let likes:Int
    let rating:Int
    let createdDate:String
    let timestamp:Timestamp
    
    init(uuid:String, dictionary: [String:Any]) {
        
        self.uuid               = uuid
        self.caption            = dictionary["caption"] as? String ?? ""
        self.imageURL           = dictionary["imageURL"] as? String ?? ""
        self.likes              = dictionary["likes"] as? Int ?? 0
        self.ownerId            = dictionary["ownerId"] as? String ?? ""
        self.ownerUserName      = dictionary["ownerUserName"] as? String ?? ""
        self.ownerProfileUrl    = dictionary["ownerProfileUrl"] as? String ?? ""
        self.rating             = dictionary["rating"] as? Int ?? 0
        self.createdDate        = dictionary["createdDate"] as? String ?? ""
        self.timestamp          = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
