//
//  RegisterStep1ViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation
import SwiftUI
import Observation
import CoreUtils

@Observable final class RegisterStep1ViewModel {
    @ObservationIgnored
    var navigationState: NavigationState?
    
    var pageState: PageState = .default
    var email: String = .empty
    
    @ObservationIgnored
    private let emailValidator: EmailValidatorInterface
    
    init(navigationState: NavigationState? = nil, emailValidator: EmailValidatorInterface = EmailValidator.shared) {
        self.navigationState = navigationState
        self.emailValidator = emailValidator
    }

    func goBack() {
        navigationState?.pop()
    }
    
    func goToStep2() {
        guard shouldNavigateNextStep() else { return }
        
        let userInputModel = RegisterInputModel(email: email)
        navigationState?.push(to: .welcome(.registerStep2(userInputModel)))
    }
    
    private func shouldNavigateNextStep() -> Bool {
        if emailValidator.isValidEmail(email) {
            return true
        }
        
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: "Lütfen geçerli bir e-posta girdiğini kontrol et.", type: .default(action: action)))
        return false
    }
}

struct RegisterInputModel: Hashable {
    var email: String = .empty
    var password: String = .empty
    var username: String = .empty
    var name: String = .empty
    var surname: String = .empty
}
