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

final class NavigationState: ObservableObject {
    @Published var routes: [Routes] = []
}
