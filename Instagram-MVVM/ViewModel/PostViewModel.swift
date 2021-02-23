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
    
    
    func fetchIfLikedUser(completion:@escaping(Bool)->Void){
        PostService.fetchIfLikedUser(postId: post.uuid) { result in
            completion(result)
        }
    }
    
    func fetchQuantityPostLikes(completion:@escaping(Int)->Void) {
        PostService.fetchQuantityPostLike(postId: post.uuid) { quantities in
            completion(quantities)
        }
    }
    
}
