//
//  Routes.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import Foundation
import Observation

enum Route: Hashable {
    case welcome(WelcomeRoutes)
    case main
    case share
    case editProfile
    case profile(String)
    
    enum WelcomeRoutes: Hashable {
        case onboarding
        case login
        case registerStep1
        case registerStep2(RegisterInputModel)
        case registerStep3(RegisterInputModel)
    }
}

@Observable final class NavigationState {
    var routes: [Route] = []
    
    func push(to route: Route) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeAll()
    }
    
    @discardableResult
    func pop(to route: Route) -> Bool {
        guard let index = routes.firstIndex(of: route) else { return false }
        routes = Array(routes[0...index])
        return true
    }
}
