//
//  WelcomeRouter.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import SwiftUI

struct WelcomeRouter {
    let routes: Route.WelcomeRoutes

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .login:
            LoginView()
        case .onboarding:
            OnboardingScreenView()
        case .registerStep1:
            RegisterStep1View()
        case .registerStep2:
            RegisterStep2View()
        case .registerStep3:
            RegisterStep3View()
        }
    }
}
