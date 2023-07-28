//
//  HomeViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    let navigationState: NavigationState
    let interactor: HomeInteractorProtocol
    
    var pageState: Binding<PageState>
    @Published var posts: [PostResponse] = []
    
    private var initialDataFetched = false

    init(navigationState: NavigationState, interactor: HomeInteractorProtocol, pageState: Binding<PageState>) {
        self.navigationState = navigationState
        self.interactor = interactor
        self.pageState = pageState
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState.wrappedValue = .default
        }
        
        pageState.wrappedValue = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }
    
    func viewOnAppear() {
        guard !initialDataFetched else { return }
        fetchPosts()
        initialDataFetched = true
    }
}

// MARK: - Network
extension HomeViewModel {
    func fetchPosts(shouldShowLoading: Bool = true) {
        pageState.wrappedValue = shouldShowLoading ? .loading : .default
        
        Task(priority: .userInitiated) {
            let result = await interactor.fetchPosts()
            await handlePostsResult(result: result)
        }
    }
    
    @MainActor
    func handlePostsResult(result: PostsResult) {
        pageState.wrappedValue = .default
        switch result {
        case .failure(let error):
            print("error.. \(error)")
        case .success(let response):
            self.posts = response
        }
    }
    
    func likeOrUnlikePost(post: PostResponse, isLiked: Bool) {
        pageState.wrappedValue = .loading
        
        Task {
            let result = await interactor.likeOrUnlikePost(postId: post.id, isLiked: isLiked)
            await handleLikeOrUnlikeResult(result, post, isLiked)
        }
    }
    
    @MainActor
    func handleLikeOrUnlikeResult(_ result: LikeStateResult, _ post: PostResponse, _ isLiked: Bool) {
        pageState.wrappedValue = .default
    }
}
