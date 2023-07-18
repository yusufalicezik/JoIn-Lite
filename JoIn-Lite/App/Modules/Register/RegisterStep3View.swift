//
//  RegisterStep3View.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI


struct RegisterStep3View: View {
    @State var name: String = .empty
    @State var surname: String = .empty
    @State var username: String = .empty
    
    @State private var pageState: PageState = .default
    @Environment(NavigationState.self) private var navigationState
    
    var body: some View {
        BaseView(pageState: $pageState, backIconAction: {
            navigationState.pop()
        }) {
            ZStack {
                Color.appSecondary.ignoresSafeArea(.all)
                VStack {
                    Text("Neredeyse bitti!").fontWeight(.heavy).font(.title2).foregroundStyle(.appPrimary).align(to: .left).padding(.top, 50)
                    Text("Ad, soyad ve kullanıcı adını seçtikten sonra artık hazırsın").align(to: .left).font(.footnote).foregroundStyle(.gray.opacity(0.8)).padding(.top, 6)
                    
                    
                    VStack(spacing: 12) {
                        HStack {
                            AuthTextField(uiModel: .init(placeholder: "Ad", isSecureField: false, textValue: $name))
                            AuthTextField(uiModel: .init(placeholder: "Soyad", isSecureField: false, textValue: $surname))
                        }
                        AuthTextField(uiModel: .init(placeholder: "Kullanıcı Adı", isSecureField: false, textValue: $username))
                        
                        Spacer()
                        
                        Button(action: {
                            pageState = .loading
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                pageState = .default
                                navigationState.popToRoot()
                                navigationState.push(to: .home)
                            }
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
