//
//  JoInTabbar.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 18.07.2023.
//

import SwiftUI

enum JOINTabItem: Int, CaseIterable {
    case home = 1
    case favorites
    case search
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Anasayfa"
        case .favorites:
            return "Favoriler"
        case .search:
            return "Ara"
        case .profile:
            return "Profil"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "home"
        case .favorites:
            return "favorite"
        case .search:
            return "search"
        case .profile:
            return "profile"
        }
    }
}

let tabbarHeight: CGFloat = 70

struct JoInTabbar: View {
    @Binding var tabSelection: Int
    @Namespace private var animateNameSpace
    private let tabItems = JOINTabItem.allCases
    
    var body: some View {
        ZStack {
            Color.white
            Rectangle()
                .foregroundColor(.white)
            
            HStack {
                ForEach(tabItems, id: \.rawValue) { item in
                    Button {
                        tabSelection = item.rawValue
                    } label: {
                        VStack {
                            Spacer(minLength: 5)
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .tint(item.rawValue == tabSelection ? .tabbarItem : .black.opacity(0.40))
                                .bold(item.rawValue == tabSelection)
                            VStack(spacing: 5) {
                                Text(item.title).foregroundColor(item.rawValue == tabSelection ? .tabbarItem : .black.opacity(0.40)).font(.footnote).fontWeight(.medium)
                                if item.rawValue == tabSelection {
                                    Capsule().frame(width: 5, height: 5)
                                        .padding(.bottom, 5).foregroundColor(.tabbarItem)
                                        .matchedGeometryEffect(id: "selectedTabId", in: animateNameSpace)
                                } else {
                                    Capsule().frame(width: 5, height: 5)
                                        .padding(.bottom, 5).foregroundColor(.clear)
                                        
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity)
                    
                }
            }
        }.frame(height: tabbarHeight)
    }
}

#Preview {
    JoInTabbar(tabSelection: .constant(1))
}
