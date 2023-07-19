//
//  EditProfileView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var username: String = .empty
    @State var name: String = .empty
    @State var surname: String = .empty
    @State var bio: String = .empty
    
    var body: some View {
        VStack {
            Text("Profilini Tamamla").font(.title2).fontWeight(.medium).padding(.top)
            
            Image(.yac).resizable().scaledToFill().frame(width: 125, height: 125).clipShape(Circle()).padding(.top, 20).onTapGesture {
                //TODO, select image and upload
            }
            
            
            VStack {
                AuthTextField(uiModel: .init(placeholder: "Kullanıcı Adı", isSecureField: false, textValue: $username))
                AuthTextField(uiModel: .init(placeholder: "Ad", isSecureField: false, textValue: $username))
                AuthTextField(uiModel: .init(placeholder: "Soyad", isSecureField: false, textValue: $username))
                AuthTextField(uiModel: .init(placeholder: "Bio", isSecureField: false, textValue: $username))
            }.padding(.top).padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                //Save action
            }, label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.appPrimary)
                    .frame(height: 55)
                    .overlay {
                        Text("Kaydet")
                            .foregroundStyle(.appSecondary)
                            .font(.headline)
                            .bold()
                    }
            }).frame(height: 55).padding(.vertical, 45).padding(.horizontal)
        }
    }
}

#Preview {
    EditProfileView()
}
