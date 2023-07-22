//
//  LoginResponseModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

struct LoginResponseModel: Decodable {
    let user: UserResponse
    let token: String
}
