//
//  OnboardingView.swift
//  CompleteApp1
//
//  Created by Yusuf Ali Cezik on 16.06.2023.
//

import SwiftUI

struct OnboardingView: View {
    let model: OnboardingViewItemModel
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                VStack(spacing: 25) {
                    ZStack {
                        Color(.appPrimary).frame(height: reader.size.height * 0.35)
                        Text(model.header).font(.largeTitle).bold().foregroundColor(.softBlue
                        )
                    }
                    
                    VStack(spacing: 10) {
                        Text(model.title).bold()
                            .font(.title2).foregroundStyle(.appPrimary)
                        Text(model.subtitle)
                            .font(.callout).foregroundColor(.black)
                    }.padding()
                }
            }.background(Color.softBlue)
        }.ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        OnboardingView(model: (header: "header", title: "title", subtitle: "subtitle"))
    }
}

typealias OnboardingViewItemModel = (header: String, title: String, subtitle: String)
