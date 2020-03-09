//
//  Optional+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool { return self?.isEmpty ?? true }
    var isNotNilOrEmpty: Bool { return !isNilOrEmpty }
    
}
