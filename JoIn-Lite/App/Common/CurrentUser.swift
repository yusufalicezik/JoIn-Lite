//
//  CurrentUser.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation
import CoreUtils

struct CurrentUser {
    static var shared = CurrentUser()
    
    var currentUser: UserResponse?
    
    mutating func setUser(user: UserResponse) -> Bool {
        if let data = try? JSONEncoder().encode(user) {
            Defaults.save(data: data, key: DefaultsKeys.user)
            self.currentUser = user
            return true
        }
        
        return false
    }
    
    mutating func getUser() -> UserResponse? {
        if let data = Defaults.data(key: DefaultsKeys.user), let savedUser = try? JSONDecoder().decode(UserResponse.self, from: data) {
            currentUser = savedUser
            return savedUser
        }
        
        return nil
    }
}
