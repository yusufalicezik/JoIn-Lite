//
//  RegisterUserRequestModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation

struct RegisterUserRequestModel: Encodable {
    let email: String
    let password: String
    let username: String
    let name: String
    let surname: String
}
