//
//  RegisterInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import YACNetwork
import CoreUtils
import Foundation
import Environment

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
    case login(LoginRequestModel)

    var baseURL: String {
        BASE_SERVICE_URL
    }
    
    var endpointPath: String {
        switch self {
        case .register:
            "/users"
        case .login:
            "/users/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login:
            .post
        }
    }
    
    var bodyParameters: Encodable? {
        switch self {
        case .register(let requestModel):
            requestModel
        case .login(let requestModel):
            requestModel
        }
    }
    
    var headers: [URLQueryItem] {
        [URLQueryItem(name: "Content-Type", value: "application/json")]
    }
}

protocol SafeAPIEndpoint: Endpoint {}

extension SafeAPIEndpoint {
    var headers: [URLQueryItem] {
        //TODO: add token
        []
    }
}
