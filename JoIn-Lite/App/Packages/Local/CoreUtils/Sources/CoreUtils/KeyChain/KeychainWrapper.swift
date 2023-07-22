//
//  KeychainWrapper.swift
//
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

public protocol KeyChainWrapperInterface {
    func save(_ data: String, key: String)
    func get(key: String) -> String?
    func remove(key: String)
}

public final class KeychainWrapper: KeyChainWrapperInterface {
    public static let shared = KeychainWrapper()
    
    public func save(_ data: String, key: String) {
        KeychainService.saveOrUpdate(key: key, data: data)
    }
    
    public func get(key: String) -> String? {
        KeychainService.load(key: key)
    }
    
    public func remove(key: String) {
        KeychainService.remove(key: key)
    }
}
