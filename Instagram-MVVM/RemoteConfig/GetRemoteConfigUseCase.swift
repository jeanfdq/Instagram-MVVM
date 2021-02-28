//
//  GetRemoteConfigUseCase.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

protocol GetRemoteConfigUseCaseProtocol {
    typealias KeyType = RemoteConfigKeys
    
    func getValue(forKey key: KeyType) -> String?
    func getValue(forKey key: KeyType) -> Bool?
    func getValue(forKey key: KeyType) -> Int?
    func getValue(forKey key: KeyType) -> Double?
    func getValue(forKey key: KeyType) -> Data?
}

struct GetRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol {
    let remoteConfigService: RemoteConfigServiceProtocol
    
    init(remoteConfigService: RemoteConfigServiceProtocol = RemoteConfigService(withDefaults: RemoteConfigDefaults.getDefaults())) {
        self.remoteConfigService = remoteConfigService
    }
    
    func getValue(forKey key: KeyType) -> String? {
        return remoteConfigService.getConfig(forKey: key.rawValue)
    }
    
    func getValue(forKey key: KeyType) -> Bool? {
        return remoteConfigService.getConfig(forKey: key.rawValue)
    }
    
    func getValue(forKey key: KeyType) -> Int? {
        return remoteConfigService.getConfig(forKey: key.rawValue)
    }
    
    func getValue(forKey key: KeyType) -> Double? {
        return remoteConfigService.getConfig(forKey: key.rawValue)
    }
    
    func getValue(forKey key: KeyType) -> Data? {
        return remoteConfigService.getConfig(forKey: key.rawValue)
    }
}
