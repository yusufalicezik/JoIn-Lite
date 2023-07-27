//
//  SearchInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation
import Environment

typealias SearchUsersResult = Result<[UserResponse], NetworkError>

protocol SearchInteractorProtocol {
    func fetchUsers(query: String) async -> SearchUsersResult
    func followUser(userId: String, isFollow: Bool) async -> FollowInfoResult
}

struct SearchInteractor: SearchInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }

    func fetchUsers(query: String) async -> SearchUsersResult {
        return await networkManager.request(
            responseType: [UserResponse].self,
            requestable: SearchEndpointItem.users(query)
        )
    }
    
    func followUser(userId: String, isFollow: Bool) async -> FollowInfoResult {
        return await networkManager.request(
            responseType: EmptyResponseModel.self,
            requestable: isFollow ? SearchEndpointItem.follow(userId) : SearchEndpointItem.unfollow(userId)
        )
    }
}

enum SearchEndpointItem: SafeAPIEndpoint {
    case follow(String)
    case unfollow(String)
    case users(String)

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .follow(let userId):
            return "/users/\(userId)/follow"
        case .unfollow(let userId):
            return "/users/\(userId)/unfollow"
        case .users:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .follow, .unfollow:
            return .put
        case .users:
            return .get
        }
    }
    
    var queryParameters: Encodable? {
        switch self {
        case .users(let query):
            return SearchQueryModel(startsWithQuery: query)
        default:
            return nil
        }
    }
}

struct SearchQueryModel: Encodable {
    let startsWithQuery: String
}
