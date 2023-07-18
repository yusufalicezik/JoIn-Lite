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
    case main
    
    enum WelcomeRoutes: Hashable {
        case onboarding
        case login
        case registerStep1
        case registerStep2
        case registerStep3
    }
}

@Observable final class NavigationState {
    var routes: [Routes] = []
    
    func push(to route: Routes) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeAll()
    }
}
