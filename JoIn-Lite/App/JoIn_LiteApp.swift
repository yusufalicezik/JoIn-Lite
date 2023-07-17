//
//  JoIn_LiteApp.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 15.07.2023.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct JoIn_LiteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var navigationState = NavigationState()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routes) {
                OnboardingScreenView().navigationDestination(for: Routes.self) { route in
                    switch route {
                    case .home:
                        Text("TODO - Home")
                    case .welcome(let welcomeRoutes):
                        WelcomeRouter(routes: welcomeRoutes).configure()
                    }
                }
            }.environmentObject(navigationState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        return true
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
