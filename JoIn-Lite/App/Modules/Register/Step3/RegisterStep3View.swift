//
//  RegisterStep3View.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI


struct RegisterStep3View: View {
    @Bindable var viewModel: RegisterStep3ViewModel
    
    var body: some View {
        BaseView(pageState: $viewModel.pageState, backIconAction: {
            viewModel.goBack()
        }) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                VStack {
                    Text("Neredeyse bitti!").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Ad, soyad ve kullanıcı adını seçtikten sonra artık hazırsın").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    
                    VStack(spacing: 12) {
                        HStack {
                            AuthTextField(uiModel: .init(placeholder: "Ad", isSecureField: false, textValue: $viewModel.name))
                            AuthTextField(uiModel: .init(placeholder: "Soyad", isSecureField: false, textValue: $viewModel.surname))
                        }
                        AuthTextField(uiModel: .init(placeholder: "Kullanıcı Adı", isSecureField: false, textValue: $viewModel.username))
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.register()
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.appPrimary)
                                .frame(height: 55)
                                .overlay {
                                    Text("Kayıt Ol")
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
//    RegisterStep3View().environment(NavigationState())
//}
