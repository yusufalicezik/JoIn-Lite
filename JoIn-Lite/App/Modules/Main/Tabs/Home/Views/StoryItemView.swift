//
//  StoryItemView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct StoryItemView: View {
    
    var body: some View {
        VStack {
            Image(.yac)
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(.appPrimary, lineWidth: 1)
                }
            
            Text("William").font(.caption).foregroundStyle(.black.opacity(0.8))
                .padding(.top, 1)
        }
            
    }
}
//
//#Preview {
//    StoryItemView()
//}
