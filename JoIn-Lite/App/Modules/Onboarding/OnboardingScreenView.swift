//
//  OnboardingScreenView.swift
//  CompleteApp1
//
//  Created by Yusuf Ali Cezik on 16.06.2023.
//

import SwiftUI

struct OnboardingScreenView: View {
    @State private var tabIndex: Int = 0
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom) {
                Color.softBlue///Trick way to prevent top space - remove this line to see why this was added
                ZStack(alignment: .bottom) {
                    TabView(selection: $tabIndex) {
                        ForEach(0..<onboardingModels.count, id: \.self) { index in
                            OnboardingView(model: onboardingModels[index]).tag(index)
                        }
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                    
                    VStack {
                        if onboardingModels.count - 1 == tabIndex {
                            Text("Giriş Yap").fontWeight(.semibold).frame(maxWidth: .infinity).frame(height: 50).background(.appPrimary).cornerRadius(10).padding(.horizontal, 20).foregroundColor(.softBlue).font(.title3).padding(10)
                        }
                        
                        CustomIndicator(totalIndex: 3, selectedIndex: tabIndex).animation(.spring(), value: UUID())
                    }.padding(.bottom, 100).animation(.easeInOut, value: UUID())
                } 
            }.ignoresSafeArea()
        }.ignoresSafeArea()
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView()
    }
}


let onboardingModels: [OnboardingViewItemModel] = [
    (header: "Merhaba!", title: "Jo-In'e Hoş Geldin", subtitle: "Jo-In ile dilediğin gibi duygu ve düşüncelerini paylaşabilir, sevdiklerinle iletişimde kalabilirsin."),
   (header: "Başlayalım!", title: "Neler yapabilirsin?", subtitle: "Sevdiklerinle takipleşebilir, mesajlaşabilir ve her anın duygu ve düşüncesini onlarla paylaşabilirsin."),
    (header: "Hazırsın!", title: "Şimdi Kullanmaya Başla", subtitle: "Hemen şimdi üye olarak başlayabilirsin. Zaten bir hesabın varsa giriş yaparak devam edebilirsin.")
]
