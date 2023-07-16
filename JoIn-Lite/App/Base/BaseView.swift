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
                Text("Loading..").frame(height: 500).background(Color.red).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        pageState.wrappedValue = .default
                    }
                }
            case .popup(let popupType):
                switch popupType {
                case .default:
                    Text("Popup..")
                case .action(let leftAction, let rightAction):
                    Button(action: {
                        leftAction?()
                        pageState.wrappedValue = .default
                    }, label: {
                        Text("Popup..")
                    })
                }
            case .default:
                EmptyView()
            }
        }
    }
}

enum PageState {
    case `default`
    case loading
    case popup(PopupType)
}

enum PopupType {
    case `default`
    case action(leftAction: (() -> Void)? = nil, rightAction: (() -> Void)? = nil)
}
