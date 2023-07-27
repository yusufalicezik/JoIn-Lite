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

protocol ProfileInteractorProtocol {
    func fetchProfile(userId: String) async -> ProfileInfoResult
    func fetchPosts(userId: String) async -> PostsResult
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
}

enum ProfileEndpointItem: SafeAPIEndpoint {
    case profile(String)
    case posts(String)

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .profile(let userId):
            return "/users/\(userId)"
        case .posts(let userId):
            return "/tweets/\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .profile:
            return .get
        case .posts:
            return .get
        }
    }
}
