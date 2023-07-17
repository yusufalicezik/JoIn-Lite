//
//  Routes.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import Foundation
import Observation

enum Routes: Hashable {
    case welcome(WelcomeRoutes)
    case home
    
    enum WelcomeRoutes: Hashable {
        case onboarding
        case login
        case registerStep1
    }
}

@Observable final class NavigationState {
    var routes: [Routes] = []
}
