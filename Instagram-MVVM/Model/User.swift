//
//  User.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

struct User:Codable {
    
    let id:String
    let profileImage:String
    let email:String
    let fullName:String
    let userName:String
    let userSearch:String
    
    static func dictionaryToModel(dictionary:[String:Any]) -> Self{
        let model:User? = dictionary.toData()?.toModel()
        return model ?? User(id: "", profileImage: "", email: "", fullName: "", userName: "", userSearch:"")
    }
    
}
