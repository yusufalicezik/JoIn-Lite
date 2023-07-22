//
//  LoginViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import Foundation
import SwiftUI
import Observation
import CoreUtils

@Observable final class LoginViewModel {
    @ObservationIgnored
    private let navigationState: NavigationState
    @ObservationIgnored
    private let loginInteractor: LoginInteractorProtocol
    @ObservationIgnored
    private let defaults: DefaultsProtocol.Type ///Since it has only static methods, we do not have to create an object, just need type. defaults.save etc.
    @ObservationIgnored
    private let keychainService: KeychainServiceInterface
    @ObservationIgnored
    private let emailValidator: EmailValidatorInterface
    
    var pageState: PageState = .default
    var email: String = .empty
    var password: String = .empty
    
    init(
        navigationState: NavigationState,
        loginInteractor: LoginInteractorProtocol,
        defaults: DefaultsProtocol.Type = Defaults.self,
        keychainService: KeychainServiceInterface = KeychainService.shared,
        emailValidator: EmailValidatorInterface = EmailValidator.shared
    ) {
        self.navigationState = navigationState
        self.loginInteractor = loginInteractor
        self.defaults = defaults
        self.keychainService = keychainService
        self.emailValidator = emailValidator
    }
    
    private func checkFieldsValid() -> Bool {
        guard emailValidator.isValidEmail(email) else {
            showErrorPopup(message: "Lütfen geçerli bir e-posta girdiğini kontrol et.")
            return false
        }
        guard password.count > 7 else {
            showErrorPopup(message: "Şifre en az 7 haneli olmalıdır")
            return false
        }
        
        return true
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }
    
    private func navigateToHome() {
        navigationState.push(to: .main)
    }
    
    func navigateToRegister() {
        navigationState.push(to: .welcome(.registerStep1))
    }
}

// MARK: - Network
extension LoginViewModel {
    func login() {
        guard checkFieldsValid() else { return }
        pageState = .loading
        Task(priority: .userInitiated) {
            let requestModel = LoginRequestModel(email: self.email, password: self.password)
            let result = await self.loginInteractor.login(request: requestModel)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleLoginResult(result: result)
            }
        }
    }
    
    private func handleLoginResult(result: LoginResult) {
        switch result {
        case .failure(let error):
            pageState = .default
            showErrorPopup(message: error.localizedDescription)
        case .success(let response):
            CurrentUser.shared.user = response.user
            defaults.save(data: true, key: DefaultsKeys.userLoggedIn)
            keychainService.save(response.token, key: KeychainKeys.token)
            
            pageState = .default
            navigateToHome()
        }
    }
}
