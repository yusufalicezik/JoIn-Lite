//
//  SharePostView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import IQKeyboardManagerSwift

struct SharePostView: View {
    @StateObject var viewModel: SharePostViewModel
    
    var body: some View {
        BaseView(pageState: $viewModel.pageState) {
            VStack {
                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Text("Vazgeç").foregroundStyle(.opaqueBlack)
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.sharePost()
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
                MultilineTextField(text: $viewModel.text)
            }
        }.onAppear {
            IQKeyboardManager.shared.enable = false
        }
        .onDisappear {
            IQKeyboardManager.shared.enable = true
        }
    }
}

//#Preview {
//    SharePostView().environment(NavigationState())
//}
//
