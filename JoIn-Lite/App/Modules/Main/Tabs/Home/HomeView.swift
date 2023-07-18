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
            ScrollView {
                VStack {
                    StoryViews { clickedItem in
                        print("story tapped.. \(clickedItem)")
                    }
                }.padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    HomeView()
}
