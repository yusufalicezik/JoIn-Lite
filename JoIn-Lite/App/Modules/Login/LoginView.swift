//
//  LoginView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject
    var viewModel: LoginViewModel

    var body: some View {
        BaseView(pageState: $viewModel.pageState) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Text("Hoş Geldin 👋").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                        Text("Eğer bir hesabın varsa giriş yaparak devam edebilirsin. Henüz bir hesabın bulunmuyorsa kayıt olarak aramıza katılabilirsin.").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                        
                        VStack(spacing: .zero) {
                            AuthTextField(uiModel: .init(placeholder: "E-posta", isSecureField: false, shouldShowRightAction: true, textValue: $viewModel.email))
                            AuthTextField(uiModel: .init(placeholder: "Şifre", isSecureField: true, shouldShowRightAction: true, textValue: $viewModel.password)).padding(.top)
                            Button(action: {
                                //TODO: - Forgot Password action
                            }, label: {
                                Text("Şifreni mi unuttun?").align(to: .right).font(.caption2).padding(.top, 10).padding(.trailing, 6).foregroundStyle(.gray.opacity(0.7))
                            })
                            
                            Button(action: {
                                viewModel.login()
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.appPrimary)
                                    .frame(height: 55)
                                    .overlay {
                                        Text("Giriş")
                                            .foregroundStyle(.appSecondary)
                                            .font(.headline)
                                            .bold()
                                    }
                            }).frame(height: 55).padding(.vertical, 45)
                            
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
                            
                            HStack(spacing: .zero) {
                                Text("Henüz bir hesabın yok mu? ").foregroundStyle(.gray).font(.caption)
                                Button(action: {
                                    viewModel.navigateToRegister()
                                }, label: {
                                    Text("Kayıt Ol").foregroundStyle(.appPrimary).font(.caption).bold()
                                })
                            }
                        }.padding(.top, 120)
                    }.padding(.horizontal, 24)
                    .padding(.bottom, 10)
                }
            }
        }.isolatedColorScheme(.light)
            .onAppear {
                viewModel.email.removeAll()
                viewModel.password.removeAll()
            }
    }
}

//#Preview {
//    LoginView().environment(NavigationState())
//}
