//
//  BaseView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI

struct BaseView<Content: View>: View {
    var pageState: Binding<PageState>
    let content: Content
    
    init(pageState: Binding<PageState>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.pageState = pageState
    }
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            content
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
