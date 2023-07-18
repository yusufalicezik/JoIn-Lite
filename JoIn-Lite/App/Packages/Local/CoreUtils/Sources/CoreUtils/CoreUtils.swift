// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public struct Screen {
    public static let size: CGRect = UIScreen.main.bounds
    public static let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    
    public static func getStatusBarHeight() -> CGFloat {
       var statusBarHeight: CGFloat = 0
       if #available(iOS 13.0, *) {
           let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
       } else {
           statusBarHeight = UIApplication.shared.statusBarFrame.height
       }
       return statusBarHeight
   }
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

