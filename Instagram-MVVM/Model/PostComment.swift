//
//  PostComment.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 26/02/21.
//

import Foundation

struct PostComment:Codable {
    let postId:String
    let userId:String
    let userProfileUrl:String
    let userName:String
    let userComment:String
}
