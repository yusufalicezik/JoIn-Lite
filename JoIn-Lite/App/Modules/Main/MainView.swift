//
//  MainView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI
import CoreUtils

struct MainView: View {
    @State private var tabSelection = JOINTabItem.home.rawValue
    @Environment(NavigationState.self) private var navigationState

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $tabSelection) {
                HomeView().tag(JOINTabItem.home.rawValue)
                    .addBottomPadding()
                
                FavoritesView().tag(JOINTabItem.favorites.rawValue)
                    .addBottomPadding()
                
                SearchView().tag(JOINTabItem.search.rawValue).addBottomPadding()
                
                ProfileView().tag(JOINTabItem.profile.rawValue).addBottomPadding()
            }
            .overlay(alignment: .bottom) {
                VStack(spacing: .zero) {
                    Divider().foregroundColor(.red)
                    JoInTabbar(tabSelection: $tabSelection)
                    Color.white.frame(height: Screen.safeArea.bottom)
                }
            }
            .ignoresSafeArea(.all)
            
            FloatingShareButton {
                navigationState.push(to: .share)
            }.ignoresSafeArea(.keyboard).padding(.bottom, tabbarHeight + 10)
                .padding(.trailing, 10)
                
        }
    }
}

#Preview {
    MainView().environment(NavigationState())
}

fileprivate extension View {
    func addBottomPadding() -> some View {
        self
            .padding(.bottom, tabbarHeight + Screen.safeArea.bottom)
            .ignoresSafeArea(edges: [.bottom])
    }
}
