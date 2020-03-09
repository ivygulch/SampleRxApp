//
//  AuthenticationService.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject
import Moya

class AuthenticationService: AuthenticationServiceType {

    // MARK: public vars

    lazy var serviceState: Observable<ServiceState> = self.serviceHelper.serviceStateObservable.debug("AuthenticationService")
    lazy var user: Driver<User?> = {
        let signedInObservable: Observable<User?> = self.authenticationAPIParser.parsedSignedIn.map { user -> User? in return user }
        let signedOutNoUser: Observable<User?> = self.authenticationAPIParser.parsedSignedOut.map { _ -> User? in return nil }
        return Observable.merge(signedInObservable, signedOutNoUser)
            .startWith(nil)
        .debug("user driver")
            .asDriver(onErrorJustReturn: nil)
    }()
    lazy var isSignedIn: Driver<Bool> = self.user.map { $0 != nil }
    let dispatcher: ActionDispatcher<AuthenticationAction>
    lazy var errors: Observable<Error> = {
        return authenticationAPIParser.errors
            .share()
    }()
    lazy var apiResponseErrors: Observable<APIResponseError> = self.errors
        .map { error -> APIResponseError? in
            guard let authenticationServiceError = error as? AuthenticationServiceError,
                case let .apiResponseError(apiResponseError) = authenticationServiceError
                else { return nil }
            return apiResponseError
        }
        .unwrap()

    public convenience init() {
        self.init(dispatcher: ActionDispatcher<AuthenticationAction>(),
                  authenticationAPIProvider: AuthenticationAPI.stubbedProvider())
    }

    init(dispatcher: ActionDispatcher<AuthenticationAction>,
         authenticationAPIProvider: MoyaProvider<AuthenticationAPI>) {
        self.dispatcher = dispatcher
        self.authenticationAPIProvider = authenticationAPIProvider
        let authenticationAPIActivityTracker = ActivityIndicator()
        self.authenticationAPIActivityTracker = authenticationAPIActivityTracker

        apiRequests = self.dispatcher.actions
            .flatMap { action -> Observable<APIObservableWrapper<AuthenticationAPI>> in
                return action.makeAPIRequest(withProvider: authenticationAPIProvider, activityTracker: authenticationAPIActivityTracker)
            }
            .share()

        apiRequests
            .subscribe(authenticationAPIParser.apiRequests)
            .disposed(by: disposeBag)

        serviceHelper.setInitialized()
    }

    // MARK: private vars

    private let disposeBag = DisposeBag()
    private let serviceHelper = ServiceHelper(serviceType: AuthenticationService.self)
    private let authenticationAPIParser = AuthenticationAPIParser()

    private let apiRequests: Observable<APIObservableWrapper<AuthenticationAPI>>
    private let authenticationAPIProvider: MoyaProvider<AuthenticationAPI>
    private let authenticationAPIActivityTracker: ActivityIndicator

    // MARK: private methods

}

private extension AuthenticationAction {

    func makeAPIRequest(withProvider provider: MoyaProvider<AuthenticationAPI>, activityTracker: ActivityIndicator) -> Observable<APIObservableWrapper<AuthenticationAPI>> {
        let token: AuthenticationAPI
        switch self {
        case let .signIn(username, password):
            token = .signIn(username: username, password: password)
        case .signOut:
            token = .signOut
        }

        let observable = provider.rx.request(token)
            .asObservable()
            .retry(2)
        return Observable.just(APIObservableWrapper(token, source: observable, activityIndicator: activityTracker))
    }

}
