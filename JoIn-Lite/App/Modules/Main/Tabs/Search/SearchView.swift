//
//  SearchView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils

struct SearchView: View {
    @State var searchText: String = "Klec"
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .leading) {
                    TextField("Ara", text: $searchText).padding(.horizontal).padding(.vertical, 8).background(
                        RoundedRectangle(cornerRadius: 16).fill(.softBlue)
                    )
                    if searchText.isEmpty {
                        Text("Ara").padding(.horizontal).foregroundStyle(.gray)
                    }
                }
                
                if !searchText.isEmpty {
                    Button(action: {
                        //TODO.. close the keyboard and send search request
                    }, label: {
                        Image(systemName: "magnifyingglass").foregroundStyle(.appPrimary).fontWeight(.semibold)
                    }).opacity(searchText.isEmpty ? 0 : 1)
                }
            }.animation(.spring(), value: UUID())
            LazyVStack {
                ForEach(0..<20) { item in
                    UserListItemView(isFollowing: item % 6 == 0).onTapGesture {
                        print("Go to user profile")
                    }.padding(.top, 15)
                }
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    SearchView()
}