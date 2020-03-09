//
//  HomeCoordinator.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject

class HomeCoordinator: HomeCoordinatorType {
    lazy var serviceState: Observable<ServiceState> = self.serviceHelper.serviceStateObservable
        .debug("HomeCoordinator")

    lazy var mainViewController: UIViewController = self.homeViewController

    private lazy var homeViewController: HomeViewController = {
        let result = HomeViewController.load(withViewModel: self.homeViewModel, viewActions: self.homeViewActions)
        result.tabBarItem.title = "Home"
        return result
    }()
    private lazy var homeViewModel: HomeViewModelType = {
        let actualErrors = self.authenticationService.apiResponseErrors
            .map { apiResponseError -> APIResponseError? in
                return apiResponseError
            }
            .asDriver(onErrorJustReturn: nil)
        let clearErrorsOnSignIn = self.authenticationService.isSignedIn
            .filter { $0 }
            .mapTo(nil as APIResponseError?)

        let apiResponseErrorsDriver = Driver.merge(actualErrors, clearErrorsOnSignIn)
        return HomeViewModel(user: self.authenticationService.user,
                             apiResponseErrors: apiResponseErrorsDriver,
                             isSignedIn: self.authenticationService.isSignedIn)
    }()
    private lazy var homeViewActions: HomeViewActionsType = {
        return HomeViewActions(
            signInAction: { [weak self] username, password in
                guard let username = username, username.isNotEmpty,
                    let password = password, password.isNotEmpty else { return }
                self?.signIn(username: username, password: password)
        },
            signOutAction: { [weak self] in
                self?.signOut()
        }
        )
    }()
    private let serviceHelper = ServiceHelper(serviceType: HomeCoordinator.self)
    private let authenticationService: AuthenticationServiceType
    private let disposeBag = DisposeBag()

    init(authenticationService: AuthenticationServiceType) {
        self.authenticationService = authenticationService
        serviceHelper.setInitialized()
    }

    // MARK: - private methods

    private func signIn(username: String, password: String) {
        authenticationService.dispatcher.dispatch(.signIn(username: username, password: password))
    }

    private func signOut() {
        authenticationService.dispatcher.dispatch(.signOut)
    }

}
