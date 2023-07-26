//
//  SharePostRequest.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import Foundation

struct SharePostRequest: Encodable {
    let text: String
    let username: String
    let userId: String
    let user: String
}
