//
//  ProfileImageCreator.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 19.07.2023.
//

import SwiftUI

final class ProfileImageCreator {
    static func create(name: String, surname: String, width: CGFloat = 75, height: CGFloat = 75) -> some View {
        let nameChar = name.first
        let surnameChar = surname.first
        
        let fullChars = "\(nameChar!)\(surnameChar!)"

        return ZStack {
            Circle().stroke(.black, lineWidth: 0.2).frame(width: width, height: height).overlay(
                Text(fullChars.uppercased()).font(.title).foregroundStyle(.gray)
            )
        }

    }
}

