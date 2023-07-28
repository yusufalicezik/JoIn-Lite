// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum Environment: String {
    case prod
    case dev
}

public class YACSettingsBundleHelper {
    public static let shared = YACSettingsBundleHelper()
    private(set) public var currentEnvironment: Environment = .dev
    private init() {}
    

    public func setup(with environment: Environment? = nil) {
        if let environment {
            currentEnvironment = environment
            return
        }
        
        if let env = UserDefaults.standard.string(forKey: "currentEnvironment") {
            currentEnvironment = Environment(rawValue: env.lowercased()) ?? Environment.prod
        }
    }
}

public extension Environment {
    var baseUrl: String {
        switch self {
        case .prod:
//            return "https://join-6fcde0605741.herokuapp.com"
            return "https://join-2-3a3dad94528c.herokuapp.com"
        case .dev:
            return "http://127.0.0.1:3000"
        }
    }
}

public let BASE_SERVICE_URL = YACSettingsBundleHelper.shared.currentEnvironment.baseUrl
