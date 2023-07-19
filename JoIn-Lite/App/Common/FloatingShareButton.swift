//
//  FloatingShareButton.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct FloatingShareButton: View {
    var action: VoidHandler?
    
    var body: some View {
        Button(action: {
            //TODO
            action?()
        }) {
            Circle().fill(.softBlue).frame(width: 50, height: 50).overlay {
                Image(systemName: "pencil.and.scribble")
            }.foregroundStyle(.appPrimary).shadow(radius: 4)
        }
    }
}

#Preview {
    FloatingShareButton()
}
