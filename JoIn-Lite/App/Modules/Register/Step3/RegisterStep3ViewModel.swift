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
    var userInputModel: RegisterInputModel
    
    var pageState: PageState = .default
    var name: String = .empty
    var surname: String = .empty
    var username: String = .empty

    init(navigationState: NavigationState, userInputModel: RegisterInputModel) {
        self.navigationState = navigationState
        self.userInputModel = userInputModel
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
        
//        navigationState.push(to: .welcome(.registerStep3(userInputModel)))
        print("user: \(userInputModel)")
        pageState = .loading
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
}
