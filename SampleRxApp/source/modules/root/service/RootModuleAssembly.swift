//
//  RootModuleAssembly.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

class RootModuleAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: - entry point for module

        container.register(RootCoordinatorType.self) { r -> RootCoordinatorType in
            let authenticationService = r.resolveRequired(AuthenticationServiceType.self)
            return RootCoordinator(authenticationService: authenticationService,
                                   resolver: r)
        }
        .inObjectScope(.container)

        // MARK: - services supporting RootCoordinatorType public protocol

        // MARK: - For internal use
    }

}
