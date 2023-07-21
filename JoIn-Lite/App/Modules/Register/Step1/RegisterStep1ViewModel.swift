//
//  RegisterStep1ViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation
import SwiftUI
import Observation

@Observable final class RegisterStep1ViewModel {
    @ObservationIgnored
    var navigationState: NavigationState?
    
    var pageState: PageState = .default
    var email: String = .empty
    
    init(navigationState: NavigationState? = nil) {
        self.navigationState = navigationState
    }

    @ObservationIgnored
    func goBack() {
        navigationState?.pop()
    }
    
    @ObservationIgnored
    func goToStep2() {
        guard shouldNavigateNextStep() else { return }
        navigationState?.push(to: .welcome(.registerStep2(.init(email: email))))
    }
    
    @ObservationIgnored
    private func shouldNavigateNextStep() -> Bool {
        if isValidEmail(email) {
            return true
        }
        
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: "Lütfen geçerli bir e-posta girdiğini kontrol et.", type: .default(action: action)))
        return false
    }
    
    @ObservationIgnored
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct RegisterInputModel: Hashable {
    var email: String = .empty
    var password: String = .empty
    var username: String = .empty
    var name: String = .empty
    var surname: String = .empty
}
