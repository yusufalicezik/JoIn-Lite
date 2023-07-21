//
//  Screen.swift
//  
//
//  Created by Yusuf Ali Cezik on 21.07.2023.
//

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
