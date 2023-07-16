//
//  OnboardingScreenViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import Foundation
import Observation

@Observable final class OnboardingScreenViewModel {
    var tabIndex: Int = 0
    
    @ObservationIgnored
    var onboardingModels: [OnboardingViewItemModel] = [
        (header: "Merhaba!", title: "Jo-In'e Hoş Geldin", subtitle: "Jo-In ile dilediğin gibi duygu ve düşüncelerini paylaşabilir, sevdiklerinle iletişimde kalabilirsin."),
        (header: "Başlayalım!", title: "Neler yapabilirsin?", subtitle: "Sevdiklerinle takipleşebilir, mesajlaşabilir ve her anın duygu ve düşüncesini onlarla paylaşabilirsin."),
        (header: "Hazırsın!", title: "Şimdi Kullanmaya Başla", subtitle: "Hemen şimdi üye olarak başlayabilirsin. Zaten bir hesabın varsa giriş yaparak devam edebilirsin.")
    ]
    
    @ObservationIgnored
    func shouldShowLoginButton() -> Bool {
        onboardingModels.count - 1 == tabIndex
    }
}
