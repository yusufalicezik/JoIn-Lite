//
//  HomeView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.appSecondary.ignoresSafeArea(.all)
            List {
                Section {
                    StoryViews { clickedItem in
                        print("story tapped.. \(clickedItem)")
                    }
                }.modifier(ListModifier())
                
                ForEach(viewModel.posts) { post in
                    PostView(post: post).listRowBackground(Color.clear)
                }.modifier(ListModifier())
                    .padding(.top)
                    .padding(.horizontal, 16)
                
            }.modifier(ListModifier())
                .onAppear {
                    viewModel.viewOnAppear()
                }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.sharePost)) { _ in
            viewModel.fetchPosts(shouldShowLoading: false)
        }
    }
}

//#Preview {
//    HomeView()
//}
