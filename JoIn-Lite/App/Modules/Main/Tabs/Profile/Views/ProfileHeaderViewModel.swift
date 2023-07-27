//
//  ProfileHeaderViewModel.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 27.07.2023.
//

import Foundation
import SwiftUI

final class ProfileHeaderViewModel: ObservableObject {
    let profileInfo: ProfileResponseModel
    let postCount: Int

    init(profileInfo: ProfileResponseModel, postCount: Int) {
        self.profileInfo = profileInfo
        self.postCount = postCount
    }
    
    var imageExist: Bool {
        profileInfo.avatarExist ?? false
    }
    
    var isMe: Bool {
        profileInfo._id == CurrentUser.shared.currentUser?._id
    }
    
    var isFollowing: Bool {
        ((CurrentUser.shared.currentUser?.followings) ?? []).contains(profileInfo._id)
    }
    
    var headerType: HeaderAction {
        if isMe {
            return .editProfile
        } else if isFollowing {
            return .unfollow
        }
        
        return .follow
    }
    
    enum HeaderAction {
        case editProfile
        case follow
        case unfollow
    }
}
