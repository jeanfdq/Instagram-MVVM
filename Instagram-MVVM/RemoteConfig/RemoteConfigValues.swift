//
//  RemoteConfigValues.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

protocol RemoteConfigProtocol {
    associatedtype RemoteType
    typealias KeyType = GetRemoteConfigUseCase.KeyType
    
    static var identifier: KeyType { get }
    var getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol? { get set }
    
    init(getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol)
    
    func value() -> RemoteType?
}

class RemoteConfigValues: NSObject {
    
    class RCAppOut:RemoteConfigProtocol {
        
        static var identifier: KeyType = RemoteConfigKeys.app_out
        
        var getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol?
        
        required init(getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol = GetRemoteConfigUseCase()) {
            self.getRemoteConfigUseCase = getRemoteConfigUseCase
        }
        
        func value() -> Bool? {
            return getRemoteConfigUseCase?.getValue(forKey: RemoteConfigValues.RCAppOut.identifier)
        }
        
    }
    
    class RCAppOutMessage:RemoteConfigProtocol {
       
        static var identifier: KeyType = RemoteConfigKeys.app_out_msg
        
        var getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol?
        
        required init(getRemoteConfigUseCase: GetRemoteConfigUseCaseProtocol = GetRemoteConfigUseCase()) {
            self.getRemoteConfigUseCase = getRemoteConfigUseCase
        }
        
        func value() -> String? {
            return getRemoteConfigUseCase?.getValue(forKey: RemoteConfigValues.RCAppOutMessage.identifier)
        }
        
    }
    
}
