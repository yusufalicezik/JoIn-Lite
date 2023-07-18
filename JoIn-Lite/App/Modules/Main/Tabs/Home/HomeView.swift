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
            }.modifier(ListModifier())
                
//            ScrollView {
//                VStack {
//                    StoryViews { clickedItem in
//                        print("story tapped.. \(clickedItem)")
//                    }
//                    
//                    List(0..<20) { 
//                        
//                    }
//                }.padding(.horizontal, 16)
//            }
        }
    }
}

#Preview {
    HomeView()
}
