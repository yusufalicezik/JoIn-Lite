//
//  FavoritesView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(sort: \.createdAt, order: .reverse, animation: .smooth) var posts: [PostDataModel]

    var body: some View {
        ZStack {
            Color.appSecondary.ignoresSafeArea(.all)
            List {
                ForEach(posts.map { $0.toPostResponseModel() }) { post in
                    PostView(post: post).listRowBackground(Color.clear)
                }.modifier(ListModifier())
                    .padding(.top)
                    .padding(.horizontal, 16)
                
            }.modifier(ListModifier())
        }
    }
}

//#Preview {
//    FavoritesView()
//}
