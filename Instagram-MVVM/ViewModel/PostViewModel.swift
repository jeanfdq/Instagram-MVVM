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
    
    var getPost:Post{
        return post
    }
    
    var postId:String {
        return post.uuid
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
    
    var postOwnerId:String {
        return post.ownerId
    }
    
    
    func fetchIfLikedUser(completion:@escaping CompletionHandler<Bool>){
        PostService.fetchIfLikedUser(postId: post.uuid, completion)
    }
    
    func fetchQuantityPostLikes(completion:@escaping CompletionHandler<Int>) {
        PostService.fetchQuantityPostLike(postId: post.uuid, completion)
    }
    
}
