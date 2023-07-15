//
//  ContentView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 15.07.2023.
//

import SwiftUI
import CoreUtils
import Localization
import Kingfisher
import YACNetwork
import IQKeyboardManagerSwift

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(Localization.alertDefaultTitle.value)")
        }
        .padding()
    }
}

