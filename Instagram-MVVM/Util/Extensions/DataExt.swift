//
//  DataExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

extension Data {
    func toModel<T:Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    func toJSON() -> /*[String:Any]?*/ NSDictionary? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? NSDictionary
        //return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String:Any]
    }
}
