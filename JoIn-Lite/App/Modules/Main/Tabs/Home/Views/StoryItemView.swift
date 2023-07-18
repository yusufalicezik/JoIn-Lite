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
            Color.red
    //            .resizable()
                .frame(width: 65, height: 65)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.appPrimary, style: .init(lineWidth: 2)).frame(width: 65, height: 65))
            
            Text("William").font(.caption).foregroundStyle(.black.opacity(0.8))
                .padding(.top, 1)
        }
            
    }
}

#Preview {
    StoryItemView()
}
