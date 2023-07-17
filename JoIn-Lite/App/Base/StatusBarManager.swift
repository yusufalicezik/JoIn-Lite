//
//  StatusBarManager.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 17.07.2023.
//

import Foundation
import SwiftUI

struct IsolatedColorSchemeModifier: ViewModifier {
  /// The desired color scheme for the view.
  let colorScheme: ColorScheme
  /// The currently active color scheme.
  @State private var activeColorScheme: ColorScheme?

  func body(content: Content) -> some View {
    content
      .preferredColorScheme(activeColorScheme)
      .onAppear {
        activeColorScheme = colorScheme
      }
      .onDisappear {
        activeColorScheme = .none
      }
  }
}

extension View {
  /// Sets an explicit color scheme for this view and all child views. The color
  /// scheme will be removed when the view disappears.
  func isolatedColorScheme(_ colorScheme: ColorScheme) -> some View {
    modifier(IsolatedColorSchemeModifier(colorScheme: colorScheme))
  }
}
