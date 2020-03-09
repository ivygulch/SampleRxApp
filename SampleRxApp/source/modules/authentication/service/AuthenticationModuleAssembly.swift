//
//  AuthenticationModuleAssembly.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

class AuthenticationModuleAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: - entry point for module

        container.register(AuthenticationServiceType.self) { _ -> AuthenticationServiceType in
            return AuthenticationService()
        }
        .inObjectScope(.container)

        // MARK: - services supporting AuthenticationCoordinatorType public protocol

        // MARK: - For internal use
    }

}
