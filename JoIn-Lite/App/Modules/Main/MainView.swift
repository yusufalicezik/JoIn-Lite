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
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView().tag(JOINTabItem.home.rawValue)
                .addBottomPadding()
            
            ZStack {
                Color.blue
                VStack {
                    Spacer()
                    Text("Test tab1")
                }
            }.tag(JOINTabItem.favorites.rawValue)
                .addBottomPadding()
            
            ZStack {
                Color.blue
                VStack {
                    Spacer()
                    Text("Test tab1")
                }
            }.tag(JOINTabItem.search.rawValue)
            
            ZStack {
                Color.blue
                VStack {
                    Spacer()
                    Text("Test tab1")
                }
            }.tag(JOINTabItem.profile.rawValue)
        }
        .overlay(alignment: .bottom) {
            VStack(spacing: .zero) {
                Divider().foregroundColor(.red)
                JoInTabbar(tabSelection: $tabSelection)
                Color.white.frame(height: Screen.safeArea.bottom)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MainView()
}

fileprivate extension View {
    func addBottomPadding() -> some View {
        self
            .padding(.bottom, tabbarHeight + Screen.safeArea.bottom)
            .ignoresSafeArea(edges: [.bottom])
    }
}
