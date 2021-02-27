//
//  PostService.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 22/02/21.
//

import Firebase

class PostService: NSObject {
    
    class func createPost(_ user:User, _ selectedImage:UIImage, _ caption:String, _ completion:@escaping CompletionHandler<Result<Void,dbError>>) {
        
        StorageService.shared.addPhotoStorage(selectedImage, POSTS_PHOTO_PATH_STORAGE) { result in
            
            switch result {
            case .failure(_ ): completion(.failure(.insertPostPhotoError))
            case .success(let url):
                
                let uuid = UUID().uuidString
                
                let dictionary = ["uuid":uuid, "imageURL":url, "caption":caption, "createdDate": Date().getDateToString("EEEE, MMM d, yyyy"), "like":0, "rating":0, "ownerId":AuthService.shared.getCurrentUserId() ?? "","ownerUserName":user.userName, "ownerProfileUrl":user.profileImage, "timestamp":Timestamp(date: Date())] as [String : Any]
                
                COLLECTION_POSTS.document(uuid).setData(dictionary) { error in
                    
                    if let _ = error {
                        completion(.failure(.createPostError))
                    } else {
                        addComment(uuid, user, caption) { isSuccess in
                            if isSuccess {
                                completion(.success(()))
                            } else {
                                completion(.failure(.createPostError))
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    class func fetchPosts(_ completion:@escaping CompletionHandler<[Post]>) {
        
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            
            var listOfPosts = [Post]()
            
            guard let snapshotPosts = snapshot else {
                completion(listOfPosts)
                return
            }
            
            _ = snapshotPosts.documents.compactMap({ item in
                listOfPosts.append(Post(uuid: item.documentID, dictionary: item.data()))
            })
            completion(listOfPosts)
            
        }
    }
    
    class func fetchPosts(withUser userId:String, completion:@escaping([Post])->Void){
        
        var listOfPosts = [Post]()
        
        let query = COLLECTION_POSTS.whereField("ownerId", isEqualTo: userId)
        query.getDocuments { (snapshots, error) in
            
            _ = snapshots?.documents.compactMap{ item in
                listOfPosts.append(Post(uuid: item.documentID, dictionary: item.data()))
            }
            
            completion(listOfPosts)
            
        }
        
    }
    
}

// MARK: - LIKES

extension PostService {
    
    class func createPostLike(_ viewModel:PostViewModel, _ completion:@escaping CompletionHandler<Bool>) {
        
        guard let userId = AuthService.shared.getCurrentUserId() else {return}
        
        COLLECTION_LIKES.document(viewModel.postId).collection(POSTS_LIKED_USERS).getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {return}
            
            let list = documents.map { $0.documentID }
            
            if list.contains(userId) {
                
                unLikePost(viewModel.postId)
                completion(error == nil)
                
            } else {
                
                COLLECTION_LIKES.document(viewModel.postId).collection(POSTS_LIKED_USERS).document(userId).setData([:] ) { error in
                    completion(error == nil)
                }
                
            }
        }
    }
    
    class func unLikePost(_ postId:String) {
        
        guard let userId = AuthService.shared.getCurrentUserId() else {return}
        
        COLLECTION_LIKES.document(postId).collection(POSTS_LIKED_USERS).document(userId).delete()
    }
    
    class func fetchQuantityPostLike(postId:String, _ completion:@escaping CompletionHandler<Int>) {
        COLLECTION_LIKES.document(postId).collection(POSTS_LIKED_USERS).getDocuments { (snapshots, error) in
            completion(snapshots?.count ?? 0)
        }
    }
    
    class func fetchIfLikedUser( postId:String, _ completion:@escaping CompletionHandler<Bool>){
        
        guard let userId = AuthService.shared.getCurrentUserId() else {return}
        
        COLLECTION_LIKES.document(postId).collection(POSTS_LIKED_USERS).document(userId).getDocument { item, error in
            
            completion(item?.exists ?? false)
        }
        
    }
}

//MARK: - Comments

extension PostService {
    
    class func addComment(_ postId:String, _ user:User, _ comment:String, _ completion:@escaping CompletionHandler<Bool>){
        
        let postComment = PostComment(postId: postId, userId: user.id, userProfileUrl: user.profileImage, userName: user.userName, userComment: comment)
        
        guard let dictionary = postComment.toData()?.toDictionary() else {
            completion(false)
            return
        }
        
        COLLECTION_POSTS.document(postId).collection(POSTS_COMMENTED_USERS).document(user.id).setData(dictionary) { error in
            completion(error == nil)
        }
        
    }
    
    class func fetchComments(_ postId:String, _ completion:@escaping CompletionHandler<[PostComment]>){
        
        COLLECTION_POSTS.document(postId).collection(POSTS_COMMENTED_USERS).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            var listComments = [PostComment]()
            
            _  = snapshot.documents.map { item in
                if let commentData = item.data().toData() {
                    if let postComment:PostComment = commentData.toModel() {
                        listComments.append(postComment)
                    }
                }
            }
            completion(listComments)
        }
    }
    
}
