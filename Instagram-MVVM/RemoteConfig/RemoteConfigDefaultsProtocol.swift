//
//  RemoteConfigDefaultsProtocol.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

protocol RemoteConfigDefaultsProtocol {
    static var defaults: [GetRemoteConfigUseCase.KeyType: Any] { get }
    static func getDefaults() -> [String: NSObject]
}

extension RemoteConfigDefaultsProtocol {
    static func getDefaults() -> [String: NSObject] {
        var defaultsFirebaseType: [String: NSObject] = [:]
        defaults.forEach {
            defaultsFirebaseType[$0.key.rawValue] = $0.value as? NSObject
        }
        
        return defaultsFirebaseType
    }
}
