//
//  UserResponse.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

struct UserResponse: Decodable {
    let _id: String
    let name: String
    let surname: String
    let username: String
    let email: String
    let followers: [String]?
    let following: [String]?
}
