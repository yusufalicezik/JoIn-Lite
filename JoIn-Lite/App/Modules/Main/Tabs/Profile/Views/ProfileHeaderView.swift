//
//  ProfileHeaderView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var isFollowing = true
    @State var isMe = false
    
    @State var imageExist = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.softBlue
            VStack(alignment: .leading) {
                HStack {
                    if imageExist {
                        Image(.yac)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle()).overlay {
                                Circle().stroke(.black, lineWidth: 0.2)
                            }
                    } else {
                        ProfileImageCreator.create(name: "Deweon", surname: "Convay")
                    }

                    
                    
                    HStack {
                        VStack(alignment: .center, spacing: 3) {
                            Text("Post").font(.caption).fontWeight(.medium).foregroundStyle(.gray)
                            Text("29").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                        VStack(alignment: .center, spacing: 3) {
                            Text("Takip Ediliyor").font(.caption).fontWeight(.medium).foregroundStyle(.gray).lineLimit(2).layoutPriority(1)
                            Text("117").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                        VStack(alignment: .center, spacing: 3) {
                            Text("Takipçi").font(.caption).fontWeight(.medium).foregroundStyle(.gray)
                            Text("8.3k").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                    }.padding(.trailing, 16)
                }
                
                Text("Devon Conway").font(.headline).padding(.top, 10)
                Text("@Klecon").foregroundStyle(.gray).font(.caption)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam").font(.caption2).foregroundStyle(.black.opacity(0.7)).padding(.vertical, 5)
                
                Button(action: {
                    //TODO: follow/unfollow, move these actions to vm
                    if isMe {
                        
                    } else {
                        isFollowing.toggle()
                    }
                }, label: {
                    
                    if isMe {
                        Text("Profili Düzenle").font(.subheadline).fontWeight(.medium).frame(maxWidth: .infinity).padding(.vertical, 10).overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.appPrimary, lineWidth: 1)
                        }.foregroundStyle(.appPrimary)
                    } else if isFollowing {
                        Text("Takip Ediliyor").font(.subheadline).fontWeight(.medium).frame(maxWidth: .infinity).padding(.vertical, 10).overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.appPrimary, lineWidth: 1)
                        }.foregroundStyle(.appPrimary)
                    } else {
                        Text("Takip Et").font(.subheadline).fontWeight(.medium).frame(maxWidth: .infinity).padding(.vertical, 10).background(
                            RoundedRectangle(cornerRadius: 10).fill(.appPrimary)
                        ).foregroundStyle(.white)
                    }
                }).padding(.horizontal, 2)
            }.animation(.spring(), value: UUID())
        }
    }
}

#Preview {
    ProfileHeaderView()
}
