//
//  LoadingView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI

struct LoadingView: View {
    @State var drawingStroke = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 15).trim(from: .zero, to: drawingStroke ? 1 : .zero).stroke(Color.appPrimary, style: StrokeStyle(lineWidth: 12, lineCap: .round)).rotationEffect(drawingStroke ? .degrees(0) : .degrees(180)).frame(width: 100, height: 100).overlay {
                Text(drawingStroke ? "JoIn" : .empty).fontWeight(.heavy).font(.title).foregroundStyle(.appPrimary)
            }
        }.animation(.linear(duration: 0.8).repeatForever(autoreverses: true), value: UUID())
            .onAppear {
                drawingStroke = true
            }
    }
}
