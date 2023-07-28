//
//  HomeInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation
import Environment

typealias PostsResult = Result<[PostResponse], NetworkError>
typealias LikeStateResult = Result<EmptyResponseModel, NetworkError>

protocol HomeInteractorProtocol {
    func fetchPosts() async -> PostsResult
    func likeOrUnlikePost(postId: String, isLiked: Bool) async -> LikeStateResult
}

struct HomeInteractor: HomeInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }
    
    func fetchPosts() async -> PostsResult {
        return await networkManager.request(
            responseType: [PostResponse].self,
            requestable: HomeEndpointItem.posts
        )
    }
    
    func likeOrUnlikePost(postId: String, isLiked: Bool) async -> LikeStateResult {
        return await networkManager.request(
            responseType: EmptyResponseModel.self,
            requestable: isLiked ? HomeEndpointItem.like(postId) : HomeEndpointItem.unlike(postId)
        )
    }
}

enum HomeEndpointItem: SafeAPIEndpoint {
    case posts
    case like(String)
    case unlike(String)

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .posts:
            return "/tweets"
        case .like(let postId):
            return "/tweets/\(postId)/like"
        case .unlike(let postId):
            return "/tweets/\(postId)/unlike"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts:
            return .get
        case .like, .unlike:
            return .put
        }
    }
}
