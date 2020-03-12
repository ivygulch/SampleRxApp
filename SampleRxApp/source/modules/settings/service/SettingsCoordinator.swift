//
//  SettingsCoordinator.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject

class SettingsCoordinator: SettingsCoordinatorType {
    lazy var serviceState: Observable<ServiceState> = self.serviceHelper.serviceStateObservable
        .debug("SettingsCoordinator")

    lazy var mainViewController: UIViewController = self.settingsViewController

    private lazy var settingsViewController: SettingsViewController = {
        let result = SettingsViewController.load(withViewModel: self.settingsViewModel, viewActions: self.settingsViewActions)
        result.tabBarItem.title = "Settings"
        return result
    }()
    private lazy var settingsViewModel: SettingsViewModelType = {
        return SettingsViewModel()
    }()
    private lazy var settingsViewActions: SettingsViewActionsType = {
        return SettingsViewActions()
    }()
    private let serviceHelper = ServiceHelper(serviceType: SettingsCoordinator.self)
    private let authenticationService: AuthenticationServiceType
    private let disposeBag = DisposeBag()

    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
        serviceHelper.setInitialized()
    }

    // MARK: - private methods

}
