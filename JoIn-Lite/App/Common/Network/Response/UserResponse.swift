//
//  UserResponse.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

struct UserResponse: Codable, Identifiable {
    var id: String {
        _id
    }
    
    let _id: String
    let name: String
    let surname: String
    let username: String
    let email: String
    let followers: [String]?
    var followings: [String]?
    let avatar: String?
    let avatarExist: Bool?
    let bio: String?
    let website: String?
}
