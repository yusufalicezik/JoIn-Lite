//
//  JoIn_LiteApp.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 15.07.2023.
//

import SwiftUI
import IQKeyboardManagerSwift
import Observation

@main
struct JoIn_LiteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Bindable private var navigationState = NavigationState() ///Normally (in the old version) it should be StateObject. However with the new macro used in @Observable, apple says you can use @State instead of @StateObject  because in order to be able to use @StateObject, NavigationState must conform ObservableObject but we use Observable instead of ObservableObject. Because this is the new version. Therefore navigationState must be @State, not @StateObject. But I realized that @State not works well, when it receives updates, reload whole Content such as OnboardingScreenView. So I changed it to @Bindable and it works. //https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routes) {
                OnboardingScreenView().navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainView().navigationBarBackButtonHidden(true)
                    case .welcome(let welcomeRoutes):
                        WelcomeRouter(routes: welcomeRoutes).configure().navigationBarBackButtonHidden(true)
                    case .share:
                        SharePostView().navigationBarBackButtonHidden(true)
                    case .editProfile:
                        EditProfileView().navigationBarBackButtonHidden(true)
                    }
                }.navigationBarBackButtonHidden(true)
            }.environment(navigationState)
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
        return viewControllers.count > 2
    }
}
