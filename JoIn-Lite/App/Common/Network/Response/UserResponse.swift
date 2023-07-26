//
//  UserResponse.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

struct UserResponse: Codable {
    let _id: String
    let name: String
    let surname: String
    let username: String
    let email: String
    let followers: [String]?
    let following: [String]?
    
    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case surname
        case username
        case email
        case followers
        case following
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(String.self, forKey: ._id)
        name = try container.decode(String.self, forKey: .name)
        surname = try container.decode(String.self, forKey: .surname)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        followers = try container.decodeIfPresent([String].self, forKey: .followers) ?? ["Test"]
        following = try container.decodeIfPresent([String].self, forKey: .following) ?? []
    }
}
