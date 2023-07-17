//
//  WelcomeRouter.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import SwiftUI

struct WelcomeRouter {
    let routes: Routes.WelcomeRoutes

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .login:
            LoginView().navigationBarBackButtonHidden(true)
        case .onboarding:
            OnboardingScreenView()
        case .registerStep1:
            RegisterStep1View().navigationBarBackButtonHidden(true)
        }
    }
}
