//
//  SettingsModuleAssembly.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

class SettingsModuleAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: - entry point for module

        container.register(SettingsCoordinatorType.self) { r -> SettingsCoordinatorType in
            let authenticationService = r.resolveRequired(AuthenticationServiceType.self)
            return SettingsCoordinator(authenticationService: authenticationService)
        }
        .inObjectScope(.container)

        // MARK: - services supporting SettingsCoordinatorType public protocol

        // MARK: - For internal use
    }

}
