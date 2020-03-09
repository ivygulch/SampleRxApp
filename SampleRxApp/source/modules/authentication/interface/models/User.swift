//
//  User.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation

public struct User: Decodable {

    public let userID: String
    public let username: String
    public let firstName: String
    public let lastName: String

    private enum CodingKeys: String, CodingKey {
        case userID = "id"
        case username
        case firstName
        case lastName
    }
    
}
