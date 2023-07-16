//
//  PopupView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import SwiftUI

struct PopupView: View {
    let uiModel: PopupUIModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack(spacing: .zero) {
                Text(uiModel.title)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundStyle(.appSecondary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                    Color.appPrimary
                )
                Text(uiModel.subtitle)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.5))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, minHeight: 90)
                    .background(
                        Color.appSecondary
                )
                switch uiModel.type {
                case .default(let action):
                    Button(action: {
                        action.action?()
                    }, label: {
                        Text(action.name).padding(.vertical).frame(maxWidth: .infinity).background(.appPrimary).foregroundStyle(.appSecondary).font(.caption).fontWeight(.heavy)
                    })
                case .multiple(let actions):
                    HStack(spacing: .zero) {
                        ForEach(actions, id: \.id) { action in
                            HStack(spacing: 0) {
                                Button(action: {
                                    action.action?()
                                }, label: {
                                    Text(action.name).padding(.vertical).frame(maxWidth: .infinity).background(.appPrimary).foregroundStyle(.appSecondary).font(.caption).fontWeight(.heavy)
                                })
                                
                                if action.id != actions.last?.id {
                                    Rectangle().fill(.appSecondary).frame(width: 1, height: .leastNormalMagnitude)
                                }
                            }
                        }
                    }
                }
            }.background(Color.appSecondary).transition(.move(edge: .bottom)).clipShape(RoundedRectangle(cornerRadius: 16)).padding(.horizontal, 35).animation(.easeInOut, value: UUID())
        }
    }
}

#Preview {
    PopupView(uiModel: .init(title: "title", subtitle: "subtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitle", type: .multiple(actions: [PopupAction(name: "name1", action: nil), PopupAction(name: "name2", action: nil)])))
}


typealias VoidHandler = (() -> Void)


struct PopupAction: Identifiable {
    let id = UUID()
    let name: String
    let action: VoidHandler?
}

struct PopupUIModel {
    let title: String
    let subtitle: String
    let type: PopupType
    
    enum PopupType {
        case `default`(action: PopupAction)
        case multiple(actions: [PopupAction])
    }
    
    init(title: String, subtitle: String, type: PopupType = .default(action: .init(name: "Tamam", action: nil))) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

