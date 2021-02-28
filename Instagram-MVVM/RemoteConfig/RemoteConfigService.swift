//
//  RemoteConfigService.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import FirebaseRemoteConfig


protocol RemoteConfigServiceProtocol {
    func fetch() -> RemoteConfig
    func getConfig(forKey key: String) -> String?
    func getConfig(forKey key: String) -> Bool?
    func getConfig(forKey key: String) -> Int?
    func getConfig(forKey key: String) -> Double?
    func getConfig(forKey key: String) -> Data?
}

struct RemoteConfigService : RemoteConfigServiceProtocol {
    
    typealias RemoteConfigDefaults = [String: NSObject]
    
    // Release Fetch options
    private let fetchDuration: TimeInterval = 0
    private let fetchTimeout: TimeInterval = 0
    
    init(withDefaults defaults: RemoteConfigDefaults) {
        RemoteConfig.remoteConfig().setDefaults(defaults)
    }
    
    func fetch() -> RemoteConfig {
        
        let remoteConfig = RemoteConfig.remoteConfig()
        
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.fetchTimeout = fetchTimeout
        remoteConfigSettings.minimumFetchInterval = fetchDuration
        
        remoteConfig.configSettings = remoteConfigSettings
        remoteConfig.fetch { (status, error) in
            
            if status == .success {
                remoteConfig.activate()
            }
            
        }
        
        return remoteConfig
        
    }
    
    private func getConfig(forKey key: String) -> RemoteConfigValue {
        return self.fetch().configValue(forKey: key)
    }
    
    func getConfig(forKey key: String) -> String? {
        return getConfig(forKey: key).stringValue
    }
    
    func getConfig(forKey key: String) -> Bool? {
        return getConfig(forKey: key).boolValue
    }
    
    func getConfig(forKey key: String) -> Int? {
        return getConfig(forKey: key).numberValue.intValue
    }
    
    func getConfig(forKey key: String) -> Double? {
        return getConfig(forKey: key).numberValue.doubleValue
    }
    
    func getConfig(forKey key: String) -> Data? {
        return getConfig(forKey: key).dataValue
    }
    
}
