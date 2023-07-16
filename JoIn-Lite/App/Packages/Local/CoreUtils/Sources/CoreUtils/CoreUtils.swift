// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public struct Screen {
    public static let size: CGRect = UIScreen.main.bounds
    public static let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
}

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

extension String {
    public static let empty = ""
}
