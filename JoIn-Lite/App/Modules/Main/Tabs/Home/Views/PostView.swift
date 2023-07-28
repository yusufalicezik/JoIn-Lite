//
//  PostView.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI
import CoreUtils
import Kingfisher
import Environment

struct PostView: View {
    @State var post: PostResponse
    var postSaved: Bool = false
    var shouldShowActions: Bool = false
    
    var isLiked: Bool {
        guard let currentUserId = CurrentUser.shared.currentUser?.id, let likes = post.likes else { return false }
        return likes.contains(currentUserId)
    }
    
    var likeCount: Int {
        post.likes?.count ?? .zero
    }
    
    var imageExist: Bool {
        post.image == "true"
    }
    
    var didTapSavePost: VoidHandler?
    var didTapLikePost: ((Bool) -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: "\(BASE_SERVICE_URL)/tweets/\(post.userId)/avatar"))
                    .placeholder({
                        ProfileImageCreator.create(name: userNameAndSurname.name, surname: userNameAndSurname.surname, width: 37, height: 37)
                    })
                    .resizable()
                    .scaledToFill()
                    .frame(width: 37, height: 37)
                    .clipShape(Circle()).overlay {
                        Circle().stroke(.black, lineWidth: 0.2)
                    }
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text(post.user).font(.footnote).fontWeight(.heavy)
                    Text("@\(post.username)").font(.caption).fontWeight(.regular)
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "ellipsis").foregroundStyle(.opaqueBlack)
                })
            }
            
            VStack(alignment: .leading) {

                if imageExist {
                    KFImage(URL(string: "\(BASE_SERVICE_URL)/tweets/\(post.id)/image"))
                        .resizable()
                        .scaledToFill()
                        .frame(height: Screen.size.width * 0.6)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            
                Text(post.text).font(imageExist ? .footnote : .subheadline).fontWeight(.light).padding(.leading, 3)
                    .padding(.top, 5)
                
                
                if shouldShowActions {
                    HStack {
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(isLiked ? .white : .black)
                                .onTapGesture {
                                    didTapLikePost?(!isLiked)
                                    likeOrUnlikePost(!isLiked)
                                }
                            if isLiked {
                                Text("\(likeCount)").font(.subheadline).foregroundStyle(.white)
                            }
                        }.padding(.vertical, isLiked ? 6 : .zero).padding(.horizontal, isLiked ? 10  : .zero).background(isLiked ? .appPrimary : .clear).clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        
                        ShareLink(item: post.text) {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.black)
                                .padding(5)
                        }
                        
                        Spacer()
                        
                        Image(systemName: postSaved ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 20)
                            .foregroundStyle(.black)
                            .padding(5).onTapGesture {
                                didTapSavePost?()
                            }

                        
                    }.padding(.top)
                }
                
                Text("12 Saat Önce").align(to: .right).padding(.top, 8).font(.caption2).foregroundStyle(.opaqueBlack)
                
            }.padding(.top, 16)
            
        }.padding().background(RoundedRectangle(cornerRadius: 16).fill(.softBlue))
    }
    
    private func likeOrUnlikePost(_ isLiked: Bool) {
        guard let currentUserId = CurrentUser.shared.currentUser?.id else { return }
        
        if isLiked {
            self.post.likes?.append(currentUserId)
        } else {
            self.post.likes?.removeAll(where: { $0 == currentUserId })
        }
    }
    
    private var userNameAndSurname: (name: String, surname: String) {
        let fullNameArr = post.user.components(separatedBy: " ")
        return (name: fullNameArr.first ?? .empty, surname: fullNameArr.last ?? .empty)
    }

}
//
//#Preview {
//    PostView(post: .init(_id: "123", text: "asdad", userId: "asdasd", username: "asdasd", user: "asdasd", image: nil, likes: nil))
//}
