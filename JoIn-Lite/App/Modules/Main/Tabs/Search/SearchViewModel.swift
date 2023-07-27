//
//  SearchViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import Foundation
import SwiftUI
import CoreUtils

final class SearchViewModel: ObservableObject {
    let navigationState: NavigationState
    let interactor: SearchInteractorProtocol
    
    var pageState: Binding<PageState>
    @Published var users: [UserResponse] = []
    @Published var searchText: String = .empty
    @Published var shouldReloadItems = false
    
    init(navigationState: NavigationState, interactor: SearchInteractorProtocol, pageState: Binding<PageState>) {
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
        users.removeAll()
        searchText.removeAll()
    }
    
    func search() {
        guard !searchText.isEmpty else { return }
        pageState.wrappedValue = .loading

        Task {
            let result = await interactor.fetchUsers(query: searchText)
            await handleResult(result: result)
        }
    }
    
    func updateFollowState(isFollow: Bool, userId: String) {
        pageState.wrappedValue = .loading

        Task {
            let followOrUnfollowResult = await self.interactor.followUser(userId: userId, isFollow: isFollow)

            await handleFollowResults(result: followOrUnfollowResult, isFollow: isFollow, userId: userId)
        }
    }
    
    @MainActor
    func handleResult(result: SearchUsersResult) {
        pageState.wrappedValue = .default
        
        switch result {
        case .failure(let error):
            showErrorPopup(message: "Arama başarısız oldu, \(error.localizedDescription)")
        case .success(let users):
            self.users = users
        }
    }
    
    @MainActor
    func handleFollowResults(result: FollowInfoResult, isFollow: Bool, userId: String) {
        pageState.wrappedValue = .default

        switch result {
        case .failure(let error):
            showErrorPopup(message: "İşlem tamamlanamadı, \(error.localizedDescription)")
        case .success:
            if isFollow {
                CurrentUser.shared.currentUser?.followings?.append(userId)
            } else {
                CurrentUser.shared.currentUser?.followings?.removeAll(where: { $0 == userId })

            }
            shouldReloadItems.toggle()
        }
    }
}
