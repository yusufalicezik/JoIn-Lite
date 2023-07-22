//
//  LoginInteractor.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import YACNetwork
import Foundation

typealias LoginResult = Result<LoginResponseModel, NetworkError>

protocol LoginInteractorProtocol {
    func login(request: LoginRequestModel) async -> LoginResult
}

struct LoginInteractor: LoginInteractorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkContainer.shared) {
        self.networkManager = networkManager
    }
    
    func login(request: LoginRequestModel) async -> LoginResult {
        return await networkManager.request(
            responseType: LoginResponseModel.self,
            requestable: AuthEndpointItem.login(request)
        )
    }
}
