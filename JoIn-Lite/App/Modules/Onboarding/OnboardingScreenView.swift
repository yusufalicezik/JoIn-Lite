//
//  OnboardingScreenView.swift
//  CompleteApp1
//
//  Created by Yusuf Ali Cezik on 16.06.2023.
//

import SwiftUI
import Observation

struct OnboardingScreenView: View {
    @Bindable private var viewModel = OnboardingScreenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.softBlue///Trick way to prevent top space - remove this line to see why this was added
                ZStack(alignment: .bottom) {
                    TabView(selection: $viewModel.tabIndex) {
                        ForEach(0..<viewModel.onboardingModels.count, id: \.self) { index in
                            OnboardingView(model: viewModel.onboardingModels[index]).tag(index)
                        }
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                    
                    VStack {
                        if viewModel.onboardingModels.count - 1 == viewModel.tabIndex {
                            NavigationLink {
                                LoginView().navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Giriş Yap").fontWeight(.semibold).frame(maxWidth: .infinity).frame(height: 50).background(.appPrimary).cornerRadius(10).padding(.horizontal, 20).foregroundColor(.softBlue).font(.title3).padding(10)
                            }

                        }
                        
                        CustomIndicator(totalIndex: 3, selectedIndex: viewModel.tabIndex).animation(.spring(), value: UUID())
                    }.padding(.bottom, 100).animation(.easeInOut, value: UUID())
                }
            }.ignoresSafeArea()
        }.ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenView()
    }
}
