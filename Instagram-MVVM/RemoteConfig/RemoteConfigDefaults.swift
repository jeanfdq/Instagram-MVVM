//
//  RemoteConfigDefaults.swift
//  Instagram-MVVM
//
//  Created by Jean Paul Borges Manzini on 27/02/21.
//

import Foundation

struct RemoteConfigDefaults:RemoteConfigDefaultsProtocol {
    static var defaults: [GetRemoteConfigUseCase.KeyType: Any] = [
        RemoteConfigValues.RCAppOut.identifier:false ]
}
