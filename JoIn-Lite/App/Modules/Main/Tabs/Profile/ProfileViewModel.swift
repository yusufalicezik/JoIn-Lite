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
    
    @Published var pageState: PageState = .default
    @Published var profileInfo: ProfileResponseModel? = nil
    @Published var posts: [PostResponse] = []
    
    private var initialDataFetched = false
    private let userId: String
    
    var headerViewModel: ProfileHeaderViewModel? {
        guard let profileInfo else { return nil }
        return ProfileHeaderViewModel(profileInfo: profileInfo, postCount: posts.count)
    }
    
    var isMe: Bool {
        userId == CurrentUser.shared.currentUser?.id
    }
    
    init(navigationState: NavigationState, interactor: ProfileInteractorProtocol, userId: String) {
        self.navigationState = navigationState
        self.interactor = interactor
        self.userId = userId
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }
    
    func viewOnAppear() {
        guard !initialDataFetched else { return }
        initialDataFetched = true
        pageState = .loading
        
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
    
    func headerActionTapped(type: ProfileHeaderViewModel.HeaderAction) {
        switch type {
        case .editProfile:
            navigationState.push(to: .editProfile)
        case .follow:
            updateFollowState(isFollow: true)
        case .unfollow:
            updateFollowState(isFollow: false)
        }
    }
    
    private func updateFollowState(isFollow: Bool) {
        guard let currentUserId = CurrentUser.shared.getUser()?._id else { return }
        pageState = .loading

        Task {
            let followOrUnfollowResult = await interactor.followUser(userId: userId, isFollow: isFollow)
            async let userInfoResult = interactor.fetchUser(userId: currentUserId)
            async let profileInfoResult = interactor.fetchProfile(userId: userId)

            await handleFollowResults((userInfoResult, followOrUnfollowResult, profileInfoResult))
        }
    }
    
    func goBack() {
        navigationState.pop()
    }
}

// MARK: - Network
extension ProfileViewModel {
    
    @MainActor
    func handleResults(_ results: (ProfileInfoResult, PostsResult)) {
        pageState = .default
        
        switch results {
        case (.success(let profileResponse), .success(let postsResponse)):
            self.profileInfo = profileResponse
            self.posts = postsResponse
        default:
            showErrorPopup(message: "Profil Yüklenemedi")
        }
    }
    
    @MainActor
    func handleFollowResults(_ results: (UserInfoResult, FollowInfoResult, ProfileInfoResult)) {
        pageState = .default
        
        switch results {
        case (.success(let userInfoResult), .success, .success(let profileResponse)):
            if CurrentUser.shared.setUser(user: userInfoResult) {
                self.profileInfo = profileResponse
            }
        default:
            showErrorPopup(message: "İşlem Tamamlanamadı")
        }
    }
}
