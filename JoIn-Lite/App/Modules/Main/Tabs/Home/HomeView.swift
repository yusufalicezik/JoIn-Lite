//
//  HomeView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.appSecondary.ignoresSafeArea(.all)
            List {
                Section {
                    StoryViews { clickedItem in
                        print("story tapped.. \(clickedItem)")
                    }
                }.modifier(ListModifier())
                
                ForEach(0..<20, id: \.self) { index in
                    PostView(imageExist: index % 3 == 0).listRowBackground(Color.clear)
                }.modifier(ListModifier())
                    .padding(.top)
                    .padding(.horizontal, 16)
                
            }.modifier(ListModifier())
        }
    }
}

#Preview {
    HomeView()
}
