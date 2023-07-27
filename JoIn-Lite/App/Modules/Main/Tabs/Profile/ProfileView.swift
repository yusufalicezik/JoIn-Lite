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
        ZStack {
            Color.softBlue.ignoresSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: .zero) {
                    if let headerViewModel = viewModel.headerViewModel {
                        ProfileHeaderView(viewModel: headerViewModel, headerActionTapped: { actionType in
                            //TODO
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
