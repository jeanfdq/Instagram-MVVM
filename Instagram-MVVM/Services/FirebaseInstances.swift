//
//  FirebaseInstances.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 07/02/21.
//

import Firebase
import FirebaseFirestore

class FirebaseInstances: NSObject {
    
    static func auth() -> Auth {
        return Auth.auth()
    }
    
    static func storage() -> StorageReference {
        return Storage.storage().reference()
    }
    
    static func db() -> Firestore {
        return Firestore.firestore()
    }
    
}
