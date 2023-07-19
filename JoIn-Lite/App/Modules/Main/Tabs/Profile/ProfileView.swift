//
//  ProfileView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.softBlue.ignoresSafeArea(.all)
            ScrollView(.vertical) {
                LazyVStack(spacing: .zero) {
                    ProfileHeaderView().padding(.top, Screen.safeArea.top).padding(.horizontal, 16).padding(.bottom, 16).background(
                        Color.softBlue.ignoresSafeArea(.all)
                    )
                    Divider()
                    ForEach(0..<20) { item in
                        PostView(imageExist: item % 3 == 0, isLiked: item % 7 == 0, likeCount: item).padding(.top, 8).padding(.horizontal, 0)
                        
                        Rectangle().fill(.appSecondary).frame(height: 8)
                    }
                }
            }.ignoresSafeArea(edges: [.top]).modifier(ListModifier())
        }
    }
}

#Preview {
    ProfileView()
}
