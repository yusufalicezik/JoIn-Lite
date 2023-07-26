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
    let post: PostResponse
    var likeCount = 1
    
    var isLiked: Bool {
        false
    }
    
    var imageExist: Bool {
        post.image == "true"
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(.yac)
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
                
                
                HStack {
                    HStack(alignment: .center, spacing: 5) {
                        Button(action: {
                            //TODO: Like
                        }, label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(isLiked ? .white : .black)
                                
                        })
                        if isLiked {
                            Text("\(likeCount)").font(.subheadline).foregroundStyle(.white)
                        }
                    }.padding(.vertical, isLiked ? 6 : .zero).padding(.horizontal, isLiked ? 10  : .zero).background(isLiked ? .appPrimary : .clear).clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Button(action: {
                        //TODO: Like
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black)
                            .padding(5)
                    })
                    
                    Spacer()
                    
                    Button {
                        //TODO: Save (add favs with using swift data)
                    } label: {
                        Button(action: {
                            //TODO: Like
                        }, label: {
                            Image(systemName: "bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 20)
                                .foregroundStyle(.black)
                                .padding(5)
                        })
                    }

                    
                }.padding(.top)
                
                
                Text("12 Saat Önce").align(to: .right).padding(.top, 8).font(.caption2).foregroundStyle(.opaqueBlack)
                
            }.padding(.top, 16)
            
        }.padding().background(RoundedRectangle(cornerRadius: 16).fill(.softBlue))
    }
}

//#Preview {
//    PostView()
//}
