//
//  ProfileInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation
import Environment

typealias ProfileInfoResult = Result<ProfileResponseModel, NetworkError>
typealias UserInfoResult = Result<UserResponse, NetworkError>
typealias FollowInfoResult = Result<EmptyResponseModel, NetworkError>

protocol ProfileInteractorProtocol {
    func fetchProfile(userId: String) async -> ProfileInfoResult
    func fetchPosts(userId: String) async -> PostsResult
    func fetchUser(userId: String) async -> UserInfoResult //In order to fetch current user again, so we can update following state
    func followUser(userId: String, isFollow: Bool) async -> FollowInfoResult
}

struct ProfileInteractor: ProfileInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }
    
    func fetchProfile(userId: String) async -> ProfileInfoResult {
        return await networkManager.request(
            responseType: ProfileResponseModel.self,
            requestable: ProfileEndpointItem.profile(userId)
        )
    }
    
    func fetchPosts(userId: String) async -> PostsResult {
        return await networkManager.request(
            responseType: [PostResponse].self,
            requestable: ProfileEndpointItem.posts(userId)
        )
    }
    
    func fetchUser(userId: String) async -> UserInfoResult {
        return await networkManager.request(
            responseType: UserResponse.self,
            requestable: ProfileEndpointItem.user(userId)
        )
    }
    
    func followUser(userId: String, isFollow: Bool) async -> FollowInfoResult {
        return await networkManager.request(
            responseType: EmptyResponseModel.self,
            requestable: isFollow ? ProfileEndpointItem.follow(userId) : ProfileEndpointItem.unfollow(userId)
        )
    }
}

enum ProfileEndpointItem: SafeAPIEndpoint {
    case profile(String)
    case posts(String)
    case follow(String)
    case unfollow(String)
    case user(String)

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .profile(let userId):
            return "/users/\(userId)"
        case .posts(let userId):
            return "/tweets/\(userId)"
        case .follow(let userId):
            return "/users/\(userId)/follow"
        case .unfollow(let userId):
            return "/users/\(userId)/unfollow"
        case .user(let userId):
            return "/users/\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .profile:
            return .get
        case .posts:
            return .get
        case .follow, .unfollow:
            return .put
        case .user:
            return .get
        }
    }
}
