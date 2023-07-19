//
//  SharePostView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import IQKeyboardManagerSwift

struct SharePostView: View {
    @State var text: String = .empty
    
    @State private var pageState: PageState = .default
    @Environment(NavigationState.self) private var navigationState
    
    var body: some View {
        BaseView(pageState: $pageState) {
            VStack {
                HStack {
                    Button {
                        navigationState.pop()
                    } label: {
                        Text("Vazgeç").foregroundStyle(.opaqueBlack)
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        pageState = .loading
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.pageState = .default
                            navigationState.pop()
                        }
                    } label: {
                        Text("Paylaş").padding(.horizontal).padding(.vertical, 5).background(RoundedRectangle(cornerRadius: 5).fill(.appPrimary)).foregroundStyle(.white)
                    }.padding(.horizontal)
                }
                
                Divider()
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "photo").foregroundStyle(.appPrimary)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.fill").foregroundStyle(.appPrimary)
                    }
                    
                    Spacer()
                }.padding(.horizontal, 6)
                Divider()
                MultilineTextField(text: $text)
            }
        }.onAppear {
            IQKeyboardManager.shared.enable = false
        }
        .onDisappear {
            IQKeyboardManager.shared.enable = true
        }
    }
}

#Preview {
    SharePostView().environment(NavigationState())
}

