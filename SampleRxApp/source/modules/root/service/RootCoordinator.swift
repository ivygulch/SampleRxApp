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
    lazy var mainViewController: UIViewController = {
        let tbc = UITabBarController()
        tbc.viewControllers = [
            self.homeCoordinator.mainViewController
        ]
        return tbc
    }()
    private let serviceHelper = ServiceHelper(serviceType: RootCoordinator.self)
    lazy var serviceState: Observable<ServiceState> = self.serviceHelper.serviceStateObservable
    .debug("RootCoordinator")

    private let authenticationService: AuthenticationServiceType
    private let homeCoordinator: HomeCoordinatorType

    init(authenticationService: AuthenticationServiceType,
         homeCoordinator: HomeCoordinatorType) {
        self.authenticationService = authenticationService
        self.homeCoordinator = homeCoordinator
        serviceHelper.setInitialized()
    }
}
