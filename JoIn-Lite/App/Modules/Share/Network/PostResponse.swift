//
//  PostResponse.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import SwiftUI

struct PostResponse: Identifiable, Decodable {
    let _id: String
    
    var id: String {
        self._id
    }
    
    let text: String
    let userId: String
    let username: String
    let user: String
}
