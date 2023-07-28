//
//  HomeView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \.createdAt, order: .reverse, animation: .smooth) var posts: [PostDataModel]
    
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
                    PostView(post: post, postSaved: isPostSaved(post: post), shouldShowActions: true, didTapSavePost: {
                        if isPostSaved(post: post) {
                            deletePost(post: post)
                        } else {
                            modelContext.insert(post.toDataModel())
                        }
                    }).listRowBackground(Color.clear)
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
    
    private func isPostSaved(post: PostResponse) -> Bool {
        posts.first(where: { $0.id == post.id }) != nil
    }
    
    private func deletePost(post: PostResponse) {
        guard let deletedData = posts.first(where: { $0.id == post.id }) else { return }
        modelContext.delete(deletedData)
    }
}

//#Preview {
//    HomeView()
//}
