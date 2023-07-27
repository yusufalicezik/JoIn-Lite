//
//  ProfileResponseModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import Foundation

struct ProfileResponseModel: Decodable {
    let _id: String
    let name: String
    let surname: String
    let username: String
    let email: String
    let followers: [String]?
    let followings: [String]?
    let avatar: String?
    let avatarExist: Bool?
    let bio: String?
    let website: String?
}
