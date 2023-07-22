//
//  KeychainService.swift
//
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation
import SwiftKeychainWrapper

public protocol KeychainServiceInterface {
    func save(_ data: String, key: String)
    func get(key: String) -> String?
    func remove(key: String)
    func removeAll()
}

public final class KeychainService: KeychainServiceInterface {
    public static let shared = KeychainService()
    
    public func save(_ data: String, key: String) {
        KeychainWrapper.standard.set(data, forKey: key)
    }
    
    public func get(key: String) -> String? {
        KeychainWrapper.standard.string(forKey: key)
    }
    
    public func remove(key: String) {
        KeychainWrapper.standard.remove(forKey: KeychainWrapper.Key(rawValue: key))
    }
    
    public func removeAll() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
