//
//  AppContainer+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

extension AppContainer {

    public var rootCoordinator: RootCoordinatorType { return resolver.resolveRequired(RootCoordinatorType.self) }

}
