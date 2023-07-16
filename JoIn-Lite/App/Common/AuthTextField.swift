//
//  AuthTextField.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI
import CoreUtils

struct AuthTextField: View {
    
    let uiModel: AuthTextFieldUIModel
    
    @State var shouldShowBorder = false
    @FocusState var isFocused
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16).fill(.enterFieldBG).stroke(shouldShowBorder ? .appPrimary : .clear, lineWidth: 0.5).frame(height: 50).overlay {
                HStack {
                    if uiModel.isSecureField {
                        SecureField(uiModel.placeholder, text: uiModel.$textValue, onCommit: {
                            shouldShowBorder = false
                        })
                        .focused($isFocused)
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.footnote)
                        .frame(height: 50)
                    } else {
                        TextField(uiModel.placeholder, text: uiModel.$textValue, onCommit: {
                            shouldShowBorder = false
                        })
                        .focused($isFocused)
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.footnote)
                        .frame(height: 50)
                    }
                }.onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    shouldShowBorder = true
                    isFocused = true
                }.padding(.horizontal, 16)
            }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                shouldShowBorder = false
            }
        }
    }
}

//#Preview {
//    AuthTextField(uiModel: .init(placeholder: "placeholder", isSecureField: false, textValue: .constant("")))
//}

struct AuthTextFieldUIModel {
    let placeholder: String
    let isSecureField: Bool
    @Binding var textValue: String
}
