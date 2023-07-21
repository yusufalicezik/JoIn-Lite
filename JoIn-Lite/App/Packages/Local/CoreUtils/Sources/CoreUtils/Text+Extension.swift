//
//  Text+Extension.swift
//  
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

import SwiftUI
public extension Text {
    enum TextAlign {
        case left
        case right
        
        var alignment: Alignment {
            self == .left
            ? .leading
            : .trailing
            
        }
    }
    
    func align(to alignment: TextAlign) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment.alignment)
    }
}
