//
//  SharePostViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import SwiftUI

final class SharePostViewModel: ObservableObject {
    @Published var text: String = .empty
    @Published var image: Image? = nil
    @Published var imagePickerPresented = false
    @Published var pageState: PageState = .default
    
    private let navigationState: NavigationState
    private let interactor: SharePostInteractorProtocol
    
    init(navigationState: NavigationState, interactor: SharePostInteractorProtocol) {
        self.navigationState = navigationState
        self.interactor = interactor
    }
    
    func goBack() {
        navigationState.pop()
    }
    
    private func showErrorPopup(message: String) {
        let action = PopupAction(name: "Tamam") { [weak self] in
            self?.pageState = .default
        }
        
        pageState = .popup(.init(title: "Uyarı", subtitle: message, type: .default(action: action)))
    }
}

// MARK: - Network
extension SharePostViewModel {
    func sharePost() {
        guard let user = CurrentUser.shared.user, !text.isEmpty else { return }
        pageState = .loading
        let request = SharePostRequest(text: text, username: user.username, userId: user._id, user: user.name)
        Task(priority: .userInitiated) {
            let result = await interactor.share(request: request)
            await handleSharePostResult(result: result)
        }
    }
    
    @MainActor
    private func handleSharePostResult(result: SharePostResult) {
        switch result {
        case .failure(let error):
            showErrorPopup(message: error.localizedDescription)
        case .success(let response):
            navigationState.pop()
        }
    }
}
