//
//  Moya+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Moya

public extension Moya.Response {

    func mapObject<T: Decodable>(_ type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }

}
