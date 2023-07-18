//
//  BaseView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI
import CoreUtils

struct BaseView<Content: View>: View {
    var pageState: Binding<PageState>
    let content: Content
    let backIconAction: VoidHandler?
    
    init(pageState: Binding<PageState>, backIconAction: VoidHandler? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.pageState = pageState
        self.backIconAction = backIconAction
    }
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            VStack(spacing: .zero) {
                //Navbar
                if let backIconAction {
                    VStack(alignment: .leading, spacing: .zero) {
                        Color.clear.frame(height: Screen.getStatusBarHeight() + Screen.safeArea.top)
                        Button(action: {
                            backIconAction()
                        }, label: {
                            Image(systemName: "arrow.left").resizable().frame(width: 20, height: 18).foregroundStyle(.appPrimary)
                        }).padding(.horizontal, 24)
                        Spacer(minLength: 10)
                        Divider()
                    }.frame(maxWidth: .infinity, alignment: .leading).frame(height: 55).ignoresSafeArea(.all)
                }
                content
            }
            switch pageState.wrappedValue {
            case .loading:
                LoadingView()
            case .popup(let uiModel):
                PopupView(uiModel: uiModel)
            case .default:
                EmptyView()
            }
        }
    }
}


enum PageState {
    case `default`
    case loading
    case popup(PopupUIModel)
}
