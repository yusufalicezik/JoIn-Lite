//
//  File.swift
//  
//
//  Created by Yusuf Ali Cezik on 16.07.2023.
//

import Foundation

public enum Localization: String {
    case alertDefaultTitle

    public var value: String {
        NSLocalizedString(
            rawValue,
            tableName: "Localizable",
            bundle: .module,
            value: "",
            comment: ""
        )
    }
}
