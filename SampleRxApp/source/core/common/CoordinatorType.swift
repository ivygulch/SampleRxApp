//
//  CoordinatorType.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift

public protocol CoordinatorType: ServiceType {
    var mainViewController: UIViewController { get }
}
