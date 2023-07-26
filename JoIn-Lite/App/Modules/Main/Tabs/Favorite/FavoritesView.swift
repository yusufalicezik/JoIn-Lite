//
//  FavoritesView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ZStack {
            Color.appSecondary.ignoresSafeArea(.all)
            List {
                ForEach(0..<20, id: \.self) { index in
//                    PostView(post: ).listRowBackground(Color.clear)
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
