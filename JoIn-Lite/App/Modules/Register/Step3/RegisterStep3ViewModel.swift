//
//  RegisterStep3ViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation
import SwiftUI
import Observation

final class RegisterStep3ViewModel: ObservableObject {
    let navigationState: NavigationState
    let registerInteractor: RegisterInteractorProtocol
    
    var userInputModel: RegisterInputModel
    
    @Published var pageState: PageState = .default
    @Published var name: String = .empty
    @Published var surname: String = .empty
    @Published var username: String = .empty

    init(navigationState: NavigationState, userInputModel: RegisterInputModel, registerInteractor: RegisterInteractorProtocol) {
        self.navigationState = navigationState
        self.userInputModel = userInputModel
        self.registerInteractor = registerInteractor
    }

    func goBack() {
        navigationState.pop()
    }
    
    func register() {
        guard checkFieldsValid() else {
            showErrorPopup(message: "Lütfen tüm bilgileri eksiksiz girdiğini kontrol et")
            return
        }
        
        userInputModel.name = name
        userInputModel.surname = surname
        userInputModel.username = username
        
        sendRegisterRequest()
    }
    
    private func checkFieldsValid() -> Bool {
        !name.isEmpty && !surname.isEmpty && !username.isEmpty
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }

    private func navigateToLogin() {
        navigationState.pop(to: .welcome(.login))
    }
}

// MARK: - Network
extension RegisterStep3ViewModel {
    private func sendRegisterRequest() {
        pageState = .loading
        Task(priority: .userInitiated) {
            let result = await registerInteractor.registerUser(request: registerUserRequest())
            await handleRegisterResult(result: result)
        }
    }
    
    @MainActor
    private func handleRegisterResult(result: RegisterUserResult) {
        pageState = .default

        switch result {
        case .failure(let error):
            showErrorPopup(message: error.localizedDescription)
        case .success:
            navigateToLogin()
        }
    }
    
    private func registerUserRequest() -> RegisterUserRequestModel {
        .init(
            email: userInputModel.email,
            password: userInputModel.password,
            username: userInputModel.username,
            name: userInputModel.name,
            surname: userInputModel.surname
        )
    }
}
