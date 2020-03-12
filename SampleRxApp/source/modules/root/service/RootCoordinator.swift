//
//  RootCoordinator.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

class RootCoordinator: RootCoordinatorType {

    lazy var mainViewController: UIViewController = self.rootTabBarController

    private lazy var rootTabBarController: RootTabBarController = {
        let result = RootTabBarController.load(withViewModel: self.rootTabBarViewModel)
        result.tabBarItem.title = "Home"
        return result
    }()
    private lazy var rootTabBarViewModel: RootTabBarViewModelType = {
        return RootTabBarViewModel(
            isSignedIn: self.authenticationService.isSignedIn,
            signedInCoordinators: [
                try! self.resolver.resolveRequired(HomeCoordinatorType.self),
                try! self.resolver.resolveRequired(SettingsCoordinatorType.self)
            ],
            signedOutCoordinators: [
                try! self.resolver.resolveRequired(HomeCoordinatorType.self)
            ]
        )
    }()

    private let serviceHelper = ServiceHelper(serviceType: RootCoordinator.self)
    lazy var serviceState: Observable<ServiceState> = self.serviceHelper.serviceStateObservable
        .debug("RootCoordinator")

    private let authenticationService: AuthenticationServiceType
    private let resolver: Resolver

    init(authenticationService: AuthenticationServiceType,
         resolver: Resolver) {
        self.authenticationService = authenticationService
        self.resolver = resolver
        serviceHelper.setInitialized()
    }
}
