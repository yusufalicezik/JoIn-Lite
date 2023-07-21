//
//  RegisterStep3ViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation
import SwiftUI
import Observation

@Observable final class RegisterStep3ViewModel {
    @ObservationIgnored
    let navigationState: NavigationState
    @ObservationIgnored
    let registerInteractor: RegisterInteractorProtocol
    
    @ObservationIgnored
    var userInputModel: RegisterInputModel
    
    var pageState: PageState = .default
    var name: String = .empty
    var surname: String = .empty
    var username: String = .empty

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

    private func navigateToHome() {
        pageState = .default
        navigationState.popToRoot()
        navigationState.push(to: .main)
    }
}

// MARK: - Network
extension RegisterStep3ViewModel {
    private func sendRegisterRequest() {
        pageState = .loading
        Task(priority: .userInitiated) {
            let result = await registerInteractor.registerUser(request: registerUserRequest())
            handleRegisterResult(result: result)
        }
    }
    
    private func handleRegisterResult(result: RegisterUserResult) {
        switch result {
        case .failure(let error):
            showErrorPopup(message: error.localizedDescription)
        case .success:
            navigateToHome()
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
