//
//  CommonTargetType.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Moya

internal struct CommonTargetHeaders {
    internal static func addDefaultHeaders(to: [String: String]) -> [String: String] {
        var headers = to
        headers["accept"] = "application/json"
        headers["Cache-Control"] = "no-cache"
        return headers
    }
}

extension Manager {
    internal static func defaultHeaders() -> [String: String] {
        return CommonTargetHeaders.addDefaultHeaders(to: self.defaultHTTPHeaders)
    }

    public static let sharedManager: Moya.Manager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHeaders()
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpCookieStorage = nil

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }()
}

public protocol CommonTargetType: TargetType {}

extension CommonTargetType {
    public var sampleData: Data { return Data() }
}
