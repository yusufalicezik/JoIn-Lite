//
//  ListModifier.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct ListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }
}
