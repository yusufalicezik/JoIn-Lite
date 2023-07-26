//
//  SharePostInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation
import Environment

typealias SharePostResult = Result<PostResponse, NetworkError>

protocol SharePostInteractorProtocol {
    func share(request: SharePostRequest) async -> SharePostResult
}

struct SharePostInteractor: SharePostInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }
    
    func share(request: SharePostRequest) async -> SharePostResult {
        return await networkManager.request(
            responseType: PostResponse.self,
            requestable: PostEndpointItem.share(request)
        )
    }
}

enum PostEndpointItem: SafeAPIEndpoint {
    case share(SharePostRequest)
    

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .share:
            return "/tweets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .share:
            return .post
        }
    }
    
    var bodyParameters: Encodable? {
        switch self {
        case .share(let requestModel):
            requestModel
        }
    }
}
