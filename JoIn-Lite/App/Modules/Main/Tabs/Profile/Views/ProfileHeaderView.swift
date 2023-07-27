//
//  ProfileHeaderView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    var viewModel: ProfileHeaderViewModel
    var headerActionTapped: ((ProfileHeaderViewModel.HeaderAction) -> Void)?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.softBlue
            VStack(alignment: .leading) {
                HStack {
                    if viewModel.imageExist {
                        Image(.yac) //TODO..
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle()).overlay {
                                Circle().stroke(.black, lineWidth: 0.2)
                            }
                    } else {
                        ProfileImageCreator.create(name: viewModel.profileInfo.name, surname: viewModel.profileInfo.surname)
                    }

                    HStack {
                        VStack(alignment: .center, spacing: 3) {
                            Text("Post").font(.caption).fontWeight(.medium).foregroundStyle(.gray) //TODO
                            Text("\(viewModel.postCount)").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                        VStack(alignment: .center, spacing: 3) {
                            Text("Takip").font(.caption).fontWeight(.medium).foregroundStyle(.gray).lineLimit(2).layoutPriority(1)
                            Text("\(viewModel.profileInfo.followings?.count ?? .zero)").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                        VStack(alignment: .center, spacing: 3) {
                            Text("Takipçi").font(.caption).fontWeight(.medium).foregroundStyle(.gray)
                            Text("\(viewModel.profileInfo.followers?.count ?? .zero)").font(.footnote).fontWeight(.heavy)
                        }.frame(maxWidth: .infinity)
                    }.padding(.trailing, 16)
                }
                
                Text(viewModel.profileInfo.name + " " + viewModel.profileInfo.surname).font(.headline).padding(.top, 10)
                Text("@\(viewModel.profileInfo.username)").foregroundStyle(.gray).font(.caption)
                
                if let bio = viewModel.profileInfo.bio {
                    Text(bio).font(.caption2).foregroundStyle(.black.opacity(0.7)).padding(.vertical, 5)
                }
                
                Button(action: {
                    headerActionTapped?(viewModel.headerType)
                }, label: {
                    
                    if viewModel.isMe {
                        Text("Profili Düzenle").font(.subheadline).fontWeight(.medium).frame(maxWidth: .infinity).padding(.vertical, 10).overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.appPrimary, lineWidth: 1)
                        }.foregroundStyle(.appPrimary)
                    } else if viewModel.isFollowing {
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

//#Preview {
//    ProfileHeaderView().environment(NavigationState())
//}
