//
//  SplashView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 22.07.2023.
//

import SwiftUI
import CoreUtils

struct SplashView: View {
    @Environment(NavigationState.self) private var navigationState

    var body: some View {
        Text("Onboarding").onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.navigateToApp()
            }
        }
    }
    
    private func navigateToApp() {
        if isUserLoggedIn() {
            navigationState.push(to: .main)
        } else {
            if isOnboardingShown() {
                navigationState.push(to: .welcome(.login))
            } else {
                navigationState.push(to: .welcome(.onboarding))
            }
        }
    }
    
    private func isUserLoggedIn() -> Bool {
        Defaults.bool(key: DefaultsKeys.userLoggedIn) && (KeychainService.shared.get(key: KeychainKeys.token) != nil)
    }
    
    private func isOnboardingShown() -> Bool {
        Defaults.bool(key: DefaultsKeys.onboardingShown)
    }
}

#Preview {
    SplashView()
}
