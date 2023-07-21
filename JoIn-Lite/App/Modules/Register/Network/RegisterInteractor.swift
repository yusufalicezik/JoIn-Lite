//
//  RegisterInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation

typealias RegisterUserResult = Result<EmptyResponseModel, NetworkError>

protocol RegisterInteractorProtocol {
    func registerUser(request: RegisterUserRequestModel) async -> RegisterUserResult
}

struct RegisterInteractor: RegisterInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }
    
    func registerUser(request: RegisterUserRequestModel) async -> RegisterUserResult {
        return await networkManager.request(
            responseType: EmptyResponseModel.self,
            requestable: AuthEndpointItem.register(request)
        )
    }
}

enum AuthEndpointItem: Endpoint {
    case register(RegisterUserRequestModel)

    var baseURL: String {
        "http://127.0.0.1:3000"
    }
    
    var endpointPath: String {
        switch self {
        case .register:
            "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            .post
        }
    }
    
    var bodyParameters: Encodable? {
        switch self {
        case .register(let requestModel):
            requestModel
        }
    }
    
    var headers: [URLQueryItem] {
        [URLQueryItem(name: "Content-Type", value: "application/json")]
    }
}
