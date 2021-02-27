//
//  Constants.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Foundation

//typealias CompletionHandler<T> = (T?, Error?) -> Void
typealias CompletionHandler<T> = (T) -> Void

let INSTANCE_AUTH               = FirebaseInstances.auth()

let COLLECTION_USERS            = FirebaseInstances.db().collection("users")
let COLLECTION_FOLLOWING        = FirebaseInstances.db().collection("following")
let COLLECTION_FOLLOWERS        = FirebaseInstances.db().collection("followers")
let COLLECTION_POSTS            = FirebaseInstances.db().collection("posts")
let COLLECTION_LIKES            = FirebaseInstances.db().collection("likes")
let COLLECTION_NOTIFICATIONS    = FirebaseInstances.db().collection("Notifications")
let COLLECTION_USER_FOLLOWING   = "user-following"
let COLLECTION_USER_FOLLOWERS   = "user-followers"
let PROFILE_PHOTO_PATH_STORAGE  = "profile_photos"
let POSTS_PHOTO_PATH_STORAGE    = "posts_photos"
let POSTS_LIKED_USERS           = "post_liked_users"
let POSTS_COMMENTED_USERS       = "post_commented_users"
let NOTIFICATIONS_USERS         = "notifications-users"



enum DefaultsManagerKeys: String {
    case userLoggedData = "userLoggedData"
}
