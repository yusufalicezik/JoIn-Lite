//
//  ProfileView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        if !viewModel.isMe {
            BaseView(pageState: $viewModel.pageState, backIconAction: {
                viewModel.goBack()
            }, content: {
                profileViewContent().ignoresSafeArea(.all)
            })
        } else {
            BaseView(pageState: $viewModel.pageState) {
                profileViewContent()
            }
        }
    }
    
    @ViewBuilder
    private func profileViewContent() -> some View {
        ZStack {
            Color.softBlue.ignoresSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: .zero) {
                    if let headerViewModel = viewModel.headerViewModel {
                        ProfileHeaderView(viewModel: headerViewModel, headerActionTapped: { actionType in
                            viewModel.headerActionTapped(type: actionType)
                        }).padding(.top, Screen.safeArea.top).padding(.horizontal, 16).padding(.bottom, 16).background(
                            Color.softBlue.ignoresSafeArea(.all)
                        )
                        Divider()
                    }
                    
                    ForEach(viewModel.posts) { post in
                        PostView(post: post).padding(.top, 8).padding(.horizontal, 0)
                        Rectangle().fill(.appSecondary).frame(height: 8)
                    }
                }
            }
            .refreshable {
                viewModel.refreshView()
            }
            .ignoresSafeArea(edges: [.top]).modifier(ListModifier())
        }.onAppear {
            viewModel.viewOnAppear()
        }
    }
}

//#Preview {
//    ProfileView()
//}
