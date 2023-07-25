//
//  RegisterStep2ViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import Foundation
import SwiftUI

final class RegisterStep2ViewModel: ObservableObject {
    let navigationState: NavigationState    
    var userInputModel: RegisterInputModel
    
    @Published var pageState: PageState = .default
    @Published var password: String = .empty
    @Published var passwordAgain: String = .empty

    init(navigationState: NavigationState, userInputModel: RegisterInputModel) {
        self.navigationState = navigationState
        self.userInputModel = userInputModel
    }

    func goBack() {
        navigationState.pop()
    }
    
    func goToStep3() {
        guard checkPasswordsValid() else { return }
        userInputModel.password = password
        navigationState.push(to: .welcome(.registerStep3(userInputModel)))
    }
    
    private func checkPasswordsValid() -> Bool {
        guard password.count > 7 else {
            showErrorPopup(message: "Şifre en az 7 haneli olmalıdır")
            return false
        }
        
        guard password == passwordAgain else {
            showErrorPopup(message: "Şifreler eşleşmiyor!")
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
}
