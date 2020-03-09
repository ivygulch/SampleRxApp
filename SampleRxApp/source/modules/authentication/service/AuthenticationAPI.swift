//
//  AuthenticationAPI.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Moya
import Result

public enum AuthenticationAPI: CommonTargetType, Equatable {
    case signIn(username: String, password: String)
    case signOut
}

private struct AuthenticationAPIConstants {
    static let baseURLString = "https://example.com/"
    static let basePath = "v1/auth/"
    static let signinPath = basePath + "signIn"
    static let signoutPath = basePath + "signOut"
}

extension AuthenticationAPI {

    public var baseURL: URL {
        return URL(string: AuthenticationAPIConstants.baseURLString)!
    }

    public var path: String {
        switch self {
        case .signIn:
            return AuthenticationAPIConstants.signinPath
        case .signOut:
            return AuthenticationAPIConstants.signoutPath
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signIn, .signOut:
            return .post
        }
    }

    public var headers: [String: String]? {
        return nil
    }

    private var parameters: [String: Any]? {
        return nil
    }

    public var task: Task {
        switch self {
        case let .signIn(username, password):
            return .requestCompositeParameters(bodyParameters: ["username": username, "password": password], bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .signOut:
            return .requestPlain
        }
    }

}

extension AuthenticationAPI {
    fileprivate static var plugins: [PluginType] {
        return []
    }

    public static let defaultProvider = newProvider()

    public static func newProvider() -> MoyaProvider<AuthenticationAPI> {
        return MoyaProvider<AuthenticationAPI>(endpointClosure: AuthenticationAPI.endpointProvider,
                                               stubClosure: MoyaProvider.neverStub,
                                               plugins: AuthenticationAPI.plugins,
                                               trackInflights: false)
    }

    public static func endpointProvider(for target: AuthenticationAPI) -> Endpoint {
        return MoyaProvider.defaultEndpointMapping(for: target)
    }

}
