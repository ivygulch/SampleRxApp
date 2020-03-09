//
//  HomeModuleAssembly.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

class HomeModuleAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: - entry point for module

        container.register(HomeCoordinatorType.self) { r -> HomeCoordinatorType in
            let authenticationService = try! r.resolveRequired(AuthenticationServiceType.self)
            return HomeCoordinator(authenticationService: authenticationService)
        }
        .inObjectScope(.container)

        // MARK: - services supporting HomeCoordinatorType public protocol

        // MARK: - For internal use
    }

}
