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

protocol HomeInteractorProtocol {
    func fetchPosts() async -> PostsResult
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
}

enum HomeEndpointItem: SafeAPIEndpoint {
    case posts
    

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .posts:
            return "/tweets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts:
            return .get
        }
    }
}
