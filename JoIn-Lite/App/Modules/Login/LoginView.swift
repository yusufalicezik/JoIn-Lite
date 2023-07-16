//
//  LoginView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = .empty
    @State var password: String = .empty
    var body: some View {
        ZStack {
            Color.appSecondary.ignoresSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Hoş Geldin 👋").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Eğer bir hesabın varsa giriş yaparak devam edebilirsin. Henüz bir hesabın bulunmuyorsa kayıt olarak aramıza katılabilirsin.").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    VStack {
                        AuthTextField(uiModel: .init(placeholder: "E-mail", isSecureField: false, textValue: $email))
                        AuthTextField(uiModel: .init(placeholder: "Password", isSecureField: true, textValue: $password))
                    }.padding(.top, 120)
                }.padding(.horizontal, 16)
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
