//
//  StoryViews.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct StoryViews: View {
    var didItemTapped: ((Int) -> Void)? //Int can be item model
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: .zero) {
                ForEach(0..<15, id: \.self) { index in
                    StoryItemView().onTapGesture {
                        didItemTapped?(index)
                    }.padding(.trailing, index == 14 ? 16 : 20) //20 spacing between items, 16 is last item's right edge inset - workaround
                        .padding(.top, 5)
                        .padding(.leading, index == 0 ? 16 : .zero) //16 is first item's left inset - workaround
                }
            }
        }
    }
}

#Preview {
    StoryViews()
}
