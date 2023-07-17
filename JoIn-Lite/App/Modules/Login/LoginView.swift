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
    
    @State private var pageState: PageState = .default
    @Environment(NavigationState.self) private var navigationState

    var body: some View {
        BaseView(pageState: $pageState) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Text("Hoş Geldin 👋").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                        Text("Eğer bir hesabın varsa giriş yaparak devam edebilirsin. Henüz bir hesabın bulunmuyorsa kayıt olarak aramıza katılabilirsin.").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                        
                        VStack(spacing: .zero) {
                            AuthTextField(uiModel: .init(placeholder: "E-posta", isSecureField: false, textValue: $email))
                            AuthTextField(uiModel: .init(placeholder: "Şifre", isSecureField: true, textValue: $password)).padding(.top)
                            Button(action: {
                                pageState = .popup(.init(title: "Uyarı", subtitle: "Şifreni sıfırlamak için e-postana bir mail gönderdik", type: .default(action: .init(name: "Tamam", action: {
                                    pageState = .default
                                }))))
                            }, label: {
                                Text("Şifreni mi unuttun?").align(to: .right).font(.caption2).padding(.top, 10).padding(.trailing, 6).foregroundStyle(.gray.opacity(0.7))
                            })
                            
                            Button(action: {
                                //Login action
                                pageState = .loading
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    let action = PopupAction(name: "Tamam") {
                                        pageState = .default
                                        navigationState.routes.append(.home)
                                    }
                                    
                                    let action2 = PopupAction(name: "Hayır") {
                                        pageState = .default
                                        print("Hayır clicked")
                                    }
                                    
                                    let popupUIModel = PopupUIModel(title: "Uyarı", subtitle: "E-mail ya da şifreniz yanlış. Lütfen bilgilerinizi kontrol ederek tekrar giriş yapmayı deneyiniz. Şifrenizi hatırlamıyorsanız şifremi unuttum diyerek parolanızı sıfırlayabilirsiniz.", type: .multiple(actions: [action, action2]))
                                    pageState = .popup(popupUIModel)
                                }
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
                            
                            HStack(spacing: .zero) {
                                Text("Henüz bir hesabın yok mu? ").foregroundStyle(.gray).font(.caption)
                                Button(action: {
                                    navigationState.routes.append(.welcome(.registerStep1))
                                }, label: {
                                    Text("Kayıt Ol").foregroundStyle(.appPrimary).font(.caption).bold()
                                })
                            }
                        }.padding(.top, 120)
                    }.padding(.horizontal, 24)
                }
            }
        }.isolatedColorScheme(.light)
    }
}

#Preview {
    LoginView()
}
