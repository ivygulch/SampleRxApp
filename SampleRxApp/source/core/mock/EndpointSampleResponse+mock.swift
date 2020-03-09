//
//  EndpointSampleResponse+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Moya

extension EndpointSampleResponse {

    static func mockResponseClosure(statusCode: Int = 200, headers: [String: String] = [:], resourceName: String) -> (() -> EndpointSampleResponse) {
        var body = ""
        if let url = Bundle.main.url(forResource: resourceName, withExtension: nil) {
            body = (try? String(contentsOf: url)) ?? ""
        }
        return mockResponseClosure(statusCode: statusCode, headers: headers, body: body)
    }

    static func mockResponseClosure(statusCode: Int = 200, headers: [String: String] = [:], body: String) -> (() -> EndpointSampleResponse) {
        let response = HTTPURLResponse(url: URL(string:"https://example.com")!, statusCode: statusCode, httpVersion: nil, headerFields: headers)!
        let data = body.data(using: .utf8)!
        return {
            .response(response, data)
        }
    }

}
