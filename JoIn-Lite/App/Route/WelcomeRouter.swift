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
            LoginView()
        case .onboarding:
            OnboardingScreenView()
        case .registerStep1:
            let viewModel = RegisterStep1ViewModel(navigationState: navigationState)
            RegisterStep1View(viewModel: viewModel)
        case .registerStep2:
            RegisterStep2View()
        case .registerStep3:
            RegisterStep3View()
        }
    }
}
