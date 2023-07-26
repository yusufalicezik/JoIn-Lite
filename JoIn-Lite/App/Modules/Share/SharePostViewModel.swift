//
//  SharePostViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import SwiftUI
import CoreUtils
import UIKit
import Environment

final class SharePostViewModel: ObservableObject {
    @Published var text: String = .empty
    @Published var image: UIImage? = nil
    @Published var imagePickerPresented = false
    @Published var pageState: PageState = .default
    
    private let navigationState: NavigationState
    private let interactor: SharePostInteractorProtocol
    private let imageUploader: ImageUploaderInterface
    
    init(navigationState: NavigationState, interactor: SharePostInteractorProtocol, imageUploader: ImageUploaderInterface = ImageUploader.shared) {
        self.navigationState = navigationState
        self.interactor = interactor
        self.imageUploader = imageUploader
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
        guard let user = CurrentUser.shared.getUser(), !text.isEmpty else { return }
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
            if let image {
                let id = response._id
                imageUploader.uploadImage(baseUrl: BASE_SERVICE_URL, "upload", fileName: "image1", image: image, urlPath: "/uploadTweetImage/\(id)") { [weak self] in
                    self?.navigationState.pop()
                }
            } else {
                navigationState.pop()
            }
        }
    }
}
