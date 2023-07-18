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
    @State var shouldShowPassword = false
    @FocusState var isFocused
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16).fill(.enterFieldBG).stroke(shouldShowBorder ? .appPrimary : .clear, lineWidth: 0.7).frame(height: 55).overlay {
                ZStack(alignment: .leading) {
                    if uiModel.textValue.isEmpty {
                        Text(uiModel.placeholder).foregroundStyle(.gray.opacity(0.55))
                            .font(.footnote)
                    }
                    HStack {
                        if uiModel.isSecureField {
                            if !shouldShowPassword {
                                SecureField(uiModel.placeholder, text: uiModel.$textValue, onCommit: {
                                    shouldShowBorder = false
                                })
                                .modifier(AuthTextFieldModifier(isFocused: $isFocused))
                            } else {
                                TextField(uiModel.placeholder, text: uiModel.$textValue, onCommit: {
                                    shouldShowBorder = false
                                })
                                .modifier(AuthTextFieldModifier(isFocused: $isFocused))
                            }
                            
                            if uiModel.shouldShowRightAction {
                                Button(action: {
                                    shouldShowPassword.toggle()
                                }, label: {
                                    Image(systemName: "eye").foregroundColor(.gray.opacity(0.4))
                                })
                            }
                        } else {
                            TextField(uiModel.placeholder, text: uiModel.$textValue, onCommit: {
                                shouldShowBorder = false
                            })
                            .modifier(AuthTextFieldModifier(isFocused: $isFocused))
                            
                            if uiModel.shouldShowRightAction {
                                Button(action: {
                                    uiModel.textValue.removeAll()
                                }, label: {
                                    Image(systemName: "xmark.circle").foregroundColor(.gray.opacity(0.4))
                                })
                            }
                        }
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
    var shouldShowRightAction: Bool = false
    @Binding var textValue: String
    
}

struct AuthTextFieldModifier: ViewModifier {
    var isFocused: FocusState<Bool>.Binding
    
    func body(content: Content) -> some View {
        content
            .focused(isFocused)
            .foregroundStyle(.black.opacity(0.7))
            .font(.footnote)
            .frame(height: 55)
    }
}
