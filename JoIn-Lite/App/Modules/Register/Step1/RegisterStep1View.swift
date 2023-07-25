//
//  RegisterStep1View.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import SwiftUI

struct RegisterStep1View: View {
    @StateObject var viewModel: RegisterStep1ViewModel
    
    var body: some View {
        BaseView(pageState: $viewModel.pageState, backIconAction: {
            viewModel.goBack()
        }) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                VStack {
                    Text("E-Posta").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Aşağıdaki alana giriş yapmak istediğin e-postanı girerek kayıt olabilirsin").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    
                    VStack(spacing: .zero) {
                        AuthTextField(uiModel: .init(placeholder: "E-posta", isSecureField: false, textValue: $viewModel.email))
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.goToStep2()
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
        }.isolatedColorScheme(.light)
        .ignoresSafeArea(.keyboard)
    }
}

//#Preview {
//    RegisterStep1View().environment(NavigationState())
//}
