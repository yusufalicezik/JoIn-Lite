// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public struct Screen {
    public static let screenSize: CGRect = UIScreen.main.bounds
    public static let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
}
