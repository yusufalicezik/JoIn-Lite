//
//  SearchView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .leading) {
                    TextField("Ara", text: $viewModel.searchText).padding(.horizontal).padding(.vertical, 8).background(
                        RoundedRectangle(cornerRadius: 16).fill(.softBlue)
                    )
                    if viewModel.searchText.isEmpty {
                        Text("Ara").padding(.horizontal).foregroundStyle(.gray)
                    }
                }
                
                if !viewModel.searchText.isEmpty {
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.search()
                    }, label: {
                        Image(systemName: "magnifyingglass").foregroundStyle(.appPrimary).fontWeight(.semibold)
                    }).opacity(viewModel.searchText.isEmpty ? 0 : 1)
                }
            }.animation(.spring(), value: UUID())
            
            if viewModel.users.isEmpty {
                ZStack {
                    Color.clear
                    Text("Takip edebileceğin kişileri ara").font(.title2).foregroundStyle(.gray)
                        .padding(.bottom, 100)
                    Spacer()
                }
            } else {
                List(viewModel.users) { user in
                    UserListItemView(user: user, didSelectItem: {
                        print("Go to user profile")
                    }).listRowSeparator(.hidden).modifier(ListModifier()).padding(.top, 15)
                }.modifier(ListModifier())
            }
            
        }.padding(.horizontal, 16)
        .onAppear {
            viewModel.viewOnAppear()
        }
    }
}

//#Preview {
//    SearchView()
//}
