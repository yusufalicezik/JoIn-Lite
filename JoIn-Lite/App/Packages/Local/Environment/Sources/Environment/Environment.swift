// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum Environment: String {
    case prod
    case dev
}

public class YACSettingsBundleHelper {
    static let shared = YACSettingsBundleHelper()
    private init() {}
    
    public var currentEnvironment: Environment {
        if let env = UserDefaults.standard.string(forKey: "currentEnvironment") {
            return Environment(rawValue: env.lowercased()) ?? Environment.prod
        }
        
        return Environment.prod
    }
}

public extension Environment {
    var baseUrl: String {
        switch self {
        case .prod:
            return "https://join-6fcde0605741.herokuapp.com"
        case .dev:
            return "http://127.0.0.1:3000"
        }
    }
}

public let BASE_SERVICE_URL = YACSettingsBundleHelper.shared.currentEnvironment.baseUrl
