//
//  SettingsCoordinatorType.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit

public protocol SettingsCoordinatorType: CoordinatorType {
    var mainViewController: UIViewController { get }
}
