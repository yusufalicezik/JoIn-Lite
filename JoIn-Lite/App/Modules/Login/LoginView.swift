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
                    
                    VStack(spacing: .zero) {
                        AuthTextField(uiModel: .init(placeholder: "E-mail", isSecureField: false, textValue: $email))
                        AuthTextField(uiModel: .init(placeholder: "Password", isSecureField: true, textValue: $password)).padding(.top)
                        Button(action: {
                            //TODO - forgot password
                        }, label: {
                            Text("Şifreni mi unuttun?").align(to: .right).font(.caption2).padding(.top, 10).padding(.trailing, 6).foregroundStyle(.gray.opacity(0.7))
                        })
                        
                        Button(action: {
                            //Login action
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.appPrimary)
                                .frame(height: 55)
                                .padding(.vertical, 45)
                                .overlay {
                                    Text("Giriş")
                                        .foregroundStyle(.appSecondary)
                                        .font(.headline)
                                        .bold()
                                }
                        })
                        
                        Divider().overlay {
                            Text(" Google ya da Facebook ile Giriş Yap ")
                                .font(.caption2)
                                .foregroundStyle(.gray.opacity(0.7))
                                .background(.appSecondary)
                        }
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 16).stroke(.softBlue, lineWidth: 1).frame(height: 55).overlay {
                                HStack {
                                    Image(.iconFacebook).resizable().frame(width: 35, height: 35).aspectRatio(contentMode: .fit)
                                    Text("Facebook").font(.caption).foregroundStyle(.gray).fontWeight(.light)
                                }
                            }
                            
                            RoundedRectangle(cornerRadius: 16).stroke(.softBlue, lineWidth: 1).frame(height: 55).overlay {
                                HStack {
                                    Image(.iconGoogle).resizable().frame(width: 35, height: 35).aspectRatio(contentMode: .fit)
                                    Text("Google").font(.caption).foregroundStyle(.gray).fontWeight(.light)
                                }
                            }
                        }.padding(.vertical, 30)
                        
                        Text("Henüz bir hesabın yok mu? ").foregroundStyle(.gray).font(.caption) + Text("Kayıt Ol").foregroundStyle(.appPrimary).font(.caption).bold()
                        
                    }.padding(.top, 120)
                }.padding(.horizontal, 24)
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
