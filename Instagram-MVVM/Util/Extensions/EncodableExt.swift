//
//  EncodableExt.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 08/02/21.
//

import Foundation

extension Encodable {
    
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
