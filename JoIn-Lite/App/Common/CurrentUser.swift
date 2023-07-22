//
//  CurrentUser.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation

struct CurrentUser {
    static var shared = CurrentUser()
    var user: UserResponse?
}
