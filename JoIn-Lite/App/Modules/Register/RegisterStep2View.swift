//
//  RegisterStep2View.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI

struct RegisterStep2View: View {
    @State var password: String = .empty
    @State var passwordAgain: String = .empty
    
    @State private var pageState: PageState = .default
    @Environment(NavigationState.self) private var navigationState
    
    var body: some View {
        BaseView(pageState: $pageState, backIconAction: {
            navigationState.pop()
        }) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                VStack {
                    Text("Şifre").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Seçtiğin şifre ile uygulamaya giriş yapacaksın").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    
                    VStack(spacing: .zero) {
                        AuthTextField(uiModel: .init(placeholder: "Şifre", isSecureField: true, textValue: $password)).padding(.top)
                        AuthTextField(uiModel: .init(placeholder: "Şifre Tekrar", isSecureField: true, textValue: $passwordAgain)).padding(.top)
                        
                        
                        Spacer()
                        
                        Button(action: {
                            pageState = .loading
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                pageState = .default
                                navigationState.push(to: .welcome(.registerStep3))
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.appPrimary)
                                .frame(height: 55)
                                .overlay {
                                    Text("Devam Et")
                                        .foregroundStyle(.appSecondary)
                                        .font(.headline)
                                        .bold()
                                }
                        }).frame(height: 55)
                    }.padding(.top, 50)
                }.padding(.horizontal, 24)
                .padding(.bottom, 10)
            }
        }.isolatedColorScheme(.light).ignoresSafeArea(.keyboard)
    }
}

//#Preview {
//    RegisterStep2View().environment(NavigationState())
//}
