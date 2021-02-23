//
//  PostService.swift
//  Instagram-MVVM
//
//  Created by Jean Paull on 22/02/21.
//

import Firebase

class PostService: NSObject {
    
    class func createPost(_ user:User, _ selectedImage:UIImage, _ caption:String, completion:@escaping (Result<Void,dbError>)->Void) {
        
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
                        completion(.success(()))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    class func fetchPosts(completion:@escaping([Post])->Void) {
        
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
    
    class func createPostLike(_ viewModel:PostViewModel, completion:@escaping(Bool)->Void) {
        
        guard let userId = AuthService.shared.getCurrentUserId() else {return}
        
        COLLECTION_LIKES.document(viewModel.postId).collection(POSTS_LIKED_USERS).document(userId).setData([:]) { error in
            completion(error == nil)
        }
        
    }
    
    class func fetchQuantityPostLike(postId:String, completion:@escaping(Int)->Void) {
        COLLECTION_LIKES.document(postId).collection(POSTS_LIKED_USERS).getDocuments { (snapshots, error) in
            completion(snapshots?.count ?? 0)
        }
    }
    
    class func fetchIfLikedUser( postId:String, completion:@escaping(Bool)->Void){
        
        guard let userId = AuthService.shared.getCurrentUserId() else {return}
        
        COLLECTION_LIKES.document(postId).collection(POSTS_LIKED_USERS).document(userId).getDocument { item, error in
            
            completion(item?.exists ?? false)
        }
        
    }
    
}
