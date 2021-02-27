//
//  PostCommentViewModel.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 26/02/21.
//

import Foundation

struct PostCommentViewModel {
    
    var postComment:PostComment
    
    init(_ postComment:PostComment) {
        self.postComment = postComment
    }
    
    var userProfileUrl:URL? {
        return URL(string: postComment.userProfileUrl)
    }
    
    var userName:String {
        return postComment.userName
    }
    
    var userComment:String {
        return postComment.userComment
    }
    
}
