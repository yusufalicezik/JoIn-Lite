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
    @State var pageState: PageState = .default
    
    private var homeViewModel: HomeViewModel {
        let interactor = HomeInteractor()
        let viewModel = HomeViewModel(navigationState: navigationState, interactor: interactor, pageState: $pageState)
        return viewModel
    }
    
    private var profileViewModel: ProfileViewModel {
        let interactor = ProfileInteractor()
        let viewModel = ProfileViewModel(navigationState: navigationState, interactor: interactor, pageState: $pageState, userId: (CurrentUser.shared.getUser()?._id) ?? .empty)
        return viewModel
    }

    var body: some View {
        BaseView(pageState: $pageState) {
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $tabSelection) {
                    HomeView(viewModel: homeViewModel).tag(JOINTabItem.home.rawValue)
                        .addBottomPadding()
                    
                    FavoritesView().tag(JOINTabItem.favorites.rawValue)
                        .addBottomPadding()
                    
                    SearchView().tag(JOINTabItem.search.rawValue).addBottomPadding()
                    
                    ProfileView(viewModel: profileViewModel).tag(JOINTabItem.profile.rawValue).addBottomPadding()
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
}

//#Preview {
//    MainView().environment(NavigationState())
//}

fileprivate extension View {
    func addBottomPadding() -> some View {
        self
            .padding(.bottom, tabbarHeight + Screen.safeArea.bottom)
            .ignoresSafeArea(edges: [.bottom])
    }
}
