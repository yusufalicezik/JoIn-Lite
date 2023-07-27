//
//  ProfileViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    let navigationState: NavigationState
    let interactor: ProfileInteractorProtocol
    
    var pageState: Binding<PageState>
    @Published var profileInfo: ProfileResponseModel? = nil
    @Published var posts: [PostResponse] = []
    
    private var initialDataFetched = false
    private let userId: String
    
    var headerViewModel: ProfileHeaderViewModel? {
        guard let profileInfo else { return nil }
        return ProfileHeaderViewModel(profileInfo: profileInfo, postCount: posts.count)
    }
    
    init(navigationState: NavigationState, interactor: ProfileInteractorProtocol, pageState: Binding<PageState>, userId: String) {
        self.navigationState = navigationState
        self.interactor = interactor
        self.pageState = pageState
        self.userId = userId
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState.wrappedValue = .default
        }
        
        pageState.wrappedValue = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }
    
    func viewOnAppear() {
        guard !initialDataFetched else { return }
        initialDataFetched = true
        pageState.wrappedValue = .loading
        
        Task {
            async let profileResult = interactor.fetchProfile(userId: userId)
            async let postsResult = interactor.fetchPosts(userId: userId)
            
            await handleResults((profileResult, postsResult))
        }
    }
    
    func refreshView() {
        initialDataFetched = false
        viewOnAppear()
    }
}

// MARK: - Network
extension ProfileViewModel {
    
    @MainActor
    func handleResults(_ results: (ProfileInfoResult, PostsResult)) {
        pageState.wrappedValue = .default
        
        switch results {
        case (.success(let profileResponse), .success(let postsResponse)):
            self.profileInfo = profileResponse
            self.posts = postsResponse
        default:
            showErrorPopup(message: "Profil Yüklenemedi")
        }
    }
}
