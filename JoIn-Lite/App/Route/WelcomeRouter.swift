//
//  WelcomeRouter.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import SwiftUI

struct WelcomeRouter {
    let routes: Route.WelcomeRoutes
    let navigationState: NavigationState

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .login:
            let loginInteractor = LoginInteractor()
            let viewModel = LoginViewModel(navigationState: navigationState, loginInteractor: loginInteractor)
            LoginView(viewModel: viewModel)
        case .onboarding:
            OnboardingScreenView()
        case .registerStep1:
            let viewModel = RegisterStep1ViewModel(navigationState: navigationState)
            RegisterStep1View(viewModel: viewModel)
        case .registerStep2(let userInputModel):
            let viewModel = RegisterStep2ViewModel(navigationState: navigationState, userInputModel: userInputModel)
            RegisterStep2View(viewModel: viewModel)
        case .registerStep3(let userInputModel):
            let registerInteractor = RegisterInteractor()
            let viewModel = RegisterStep3ViewModel(navigationState: navigationState, userInputModel: userInputModel, registerInteractor: registerInteractor)
            RegisterStep3View(viewModel: viewModel)
        }
    }
}
