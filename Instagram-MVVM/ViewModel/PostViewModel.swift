//
//  PostViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 21/02/21.
//

import Firebase

struct PostViewModel {
    
    fileprivate let post:Post
    
    init(_ post:Post) {
        self.post = post
    }
    
    var userImageUrl:URL? {
        return URL(string: post.ownerProfileUrl)
    }
    
    var userName:String {
        return post.ownerUserName
    }
    
    var caption:String {
        return post.caption
    }
    
    var imageUrl:URL? {
        return URL(string: post.imageURL)
    }
    
    var likes:Int {
        return post.likes
    }
    
}
