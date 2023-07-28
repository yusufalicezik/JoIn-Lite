//
//  PostDataModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 28.07.2023.
//

import Foundation
import SwiftData

@Model
class PostDataModel: Identifiable {
    @Attribute(.unique) var id: String
    var text: String
    var userId: String
    var username: String
    var user: String
    var image: String?
    var createdAt: Date
    
    init(id: String, text: String, userId: String, username: String, user: String, image: String? = nil, createdAt: Date) {
        self.id = id
        self.text = text
        self.userId = userId
        self.username = username
        self.user = user
        self.image = image
        self.createdAt = createdAt
    }
}

extension PostResponse {
    func toDataModel() -> PostDataModel {
        .init(id: id, text: text, userId: userId, username: username, user: user, image: image, createdAt: .now)
    }
}

extension PostDataModel {
    func toPostResponseModel() -> PostResponse {
        .init(_id: id, text: text, userId: userId, username: username, user: user, image: image)
    }
}
