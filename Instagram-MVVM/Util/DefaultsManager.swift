//
//  DefaultsManager.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 26/02/21.
//

import UIKit

extension UserDefaults {

    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}

class DefaultsManager {
    
    private static let instance = DefaultsManager()
    
    class func shared() -> DefaultsManager {
        return instance
    }
    
    // MARK: Manager
    
    func save<T>(object: T, key: DefaultsManagerKeys) {
        standard()[key.rawValue] = object
        sync()
    }
    
    func get<T>(key: DefaultsManagerKeys) -> T? {
        return standard()[key.rawValue]
    }
    
    func delete(key: DefaultsManagerKeys) {
        standard().removeObject(forKey: key.rawValue)
        sync()
    }
    
    // MARK: Helpers
    
    fileprivate func standard() -> UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate func sync() {
        standard().synchronize()
    }
}
