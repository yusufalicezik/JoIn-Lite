//
//  Defaults.swift
//
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

///Inject it -> defaults: DefaultsProtocol.Type = Defaults.self,
///defaults.save(data: data, key:  key)

public protocol DefaultsProtocol {
    static func hasKey(key: String) -> Bool
    static func save(data value: Any, key: String)
    static func remove(forKey key: String)
    static func object(key: String) -> Any?
    static func string(key: String) -> String?
    static func bool(key: String) -> Bool
    static func int(key: String) -> Int?
    static func url(key: String) -> URL?
    static func array(key: String) -> [Any]?
    static func data(key: String) -> Data?
    static func dictionary(key: String) -> [String: Any]?
    static func save<T: Encodable>(value object: T, key: String)
    static func get<T: Decodable>(with key: String, type: T.Type) -> T?
    static func save<T: Encodable>(array: [T], key: String)
    static func getArray<T: Decodable>(with key: String, type: T.Type) -> [T]?
}

public class Defaults: NSObject, DefaultsProtocol { }

public extension DefaultsProtocol {
    static func hasKey(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    static func save(data value: Any, key: String) {
        UserDefaults.standard.set(value, forKey:  key)
        UserDefaults.standard.synchronize()
    }

    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    static func object(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    static func string(key: String) -> String? {
        return UserDefaults.standard.object(forKey: key) as? String
    }
    
    static func data(key: String) -> Data? {
        return UserDefaults.standard.value(forKey: key) as? Data
    }

    static func bool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    static func int(key: String) -> Int? {
        return UserDefaults.standard.object(forKey: key) as? Int
    }

    static func url(key: String) -> URL? {
        return UserDefaults.standard.object(forKey: key) as? URL
    }

    static func array(key: String) -> [Any]? {
        return UserDefaults.standard.object(forKey: key) as? [Any]
    }

    static func array<T>(key: String) -> [T]? {
        return UserDefaults.standard.object(forKey: key) as? [T]
    }

    static func dictionary(key: String) -> [String: Any]? {
        return UserDefaults.standard.object(forKey: key) as? [String: Any]
    }

    static func save<T: Encodable>(value object: T, key: String) {
        UserDefaults.standard.set(object.data(), forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func get<T: Decodable>(with key: String, type: T.Type) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        let object = try? PropertyListDecoder().decode(type, from: data)
        return object
    }

    static func save<T: Encodable>(array: [T], key: String) {
        let data = try? PropertyListEncoder().encode(array)
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func getArray<T: Decodable>(with key: String, type: T.Type) -> [T]? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        let array = try? PropertyListDecoder().decode(Array<T>.self, from: data)
        return array
    }
}

public extension Encodable {
    func data() -> Data? {
        return try? PropertyListEncoder().encode(self)
    }

    func encoded() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

public extension UserDefaults {
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
}

