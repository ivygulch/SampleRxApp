//
//  GenericAPIResponse.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation

public struct GenericAPIResponse: Decodable {
    public let error: APIResponseError?

    private enum CodingKeys: String, CodingKey {
        case error
    }

}

public struct APIResponseError: Decodable {
    public let code: String
    public let message: String

    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    
}

