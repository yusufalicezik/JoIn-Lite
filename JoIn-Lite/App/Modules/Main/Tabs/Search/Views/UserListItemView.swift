//
//  UserListItemView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils

struct UserListItemView: View {
    var user: UserResponse
    var didSelectItem: VoidHandler?
    var didFollowTapped: ((Bool) -> Void)?

    var isFollowing: Bool {
        ((CurrentUser.shared.currentUser?.followings) ?? []).contains(user._id)
    }
    
    var body: some View {
        VStack {
            HStack {
                if user.avatarExist ?? false {
                    Image(.yac)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle()).overlay {
                            Circle().stroke(.black, lineWidth: 0.2)
                        }
                } else {
                    ProfileImageCreator.create(name: user.name, surname: user.surname, width: 40, height: 40)
                }
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text(user.name + " " + user.surname).font(.footnote).fontWeight(.bold).align(to: .left)
                    Text("@\(user.username)").font(.caption2).fontWeight(.regular).foregroundStyle(.opaqueBlack).align(to: .left)
                }
                
                
                Spacer()
                
                Text(isFollowing ? "Takip Ediliyor" : "Takip Et").foregroundStyle(.white).padding(.vertical, 5).padding(.horizontal, 12).background(.appPrimary.opacity(isFollowing ? 0.5 : 1)).font(.caption2).fontWeight(.semibold).clipShape(RoundedRectangle(cornerRadius: 9)).onTapGesture {
                    didFollowTapped?(!isFollowing)
                }
            }.contentShape(Rectangle())
            Divider().padding(.top, 5)
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            didSelectItem?()
        }
    }
}
//
//#Preview {
//    UserListItemView()
//}
