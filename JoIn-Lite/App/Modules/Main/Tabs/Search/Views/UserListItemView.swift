//
//  UserListItemView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct UserListItemView: View {
    var isFollowing = false
    
    var body: some View {
        VStack {
            HStack {
                Image(.yac)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle()).overlay {
                        Circle().stroke(.black, lineWidth: 0.2)
                    }
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("William").font(.footnote).fontWeight(.bold)
                    Text("@Klecon").font(.caption2).fontWeight(.regular).foregroundStyle(.opaqueBlack)
                }
                
                Spacer()
                
                Button(action: {
                    print("tapped followw")
                }, label: {
                    Text(isFollowing ? "Takip Ediliyor" : "Takip Et").foregroundStyle(.white).padding(.vertical, 5).padding(.horizontal, 12).background(.appPrimary.opacity(isFollowing ? 0.5 : 1)).font(.caption2).fontWeight(.semibold).clipShape(RoundedRectangle(cornerRadius: 9))
                })
            }
            Divider().padding(.top, 5)
        }
    }
}

#Preview {
    UserListItemView()
}
