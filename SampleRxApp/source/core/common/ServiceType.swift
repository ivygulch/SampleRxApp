//
//  ServiceType.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift

public enum ServiceState {
    case started
    case initialized
    case dismissed
}

public protocol ServiceType {
    var serviceState: Observable<ServiceState> { get }
}
