//
//  RegisterStep2View.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI

struct RegisterStep2View: View {
    @StateObject var viewModel: RegisterStep2ViewModel

    var body: some View {
        BaseView(pageState: $viewModel.pageState, backIconAction: {
            viewModel.goBack()
        }) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                VStack {
                    Text("Şifre").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Seçtiğin şifre ile uygulamaya giriş yapacaksın").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    
                    VStack(spacing: .zero) {
                        AuthTextField(uiModel: .init(placeholder: "Şifre", isSecureField: true, textValue: $viewModel.password)).padding(.top)
                        AuthTextField(uiModel: .init(placeholder: "Şifre Tekrar", isSecureField: true, textValue: $viewModel.passwordAgain)).padding(.top)
                        
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.goToStep3()
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
