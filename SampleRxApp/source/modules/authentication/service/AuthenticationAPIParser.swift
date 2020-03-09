//
//  AuthenticationAPIParser.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import os.log

class AuthenticationAPIParser {
    private let disposables = DisposeBag()
    private let computationScheduler = SerialDispatchQueueScheduler(qos: .userInitiated)
    let apiRequests = PublishSubject<APIObservableWrapper<AuthenticationAPI>>()

    lazy var apiRequestErrors: Observable<(Error, AuthenticationAPI)> = {
        return self.apiRequests
            .asObservable()
            .flatMap({ apiWrapper -> Observable<(Error, AuthenticationAPI)> in
                return apiWrapper.errors()
                    .map { ($0, apiWrapper.token)
                }
            })
            .share()
    }()

    lazy var apiRequestResponses: Observable<(Moya.Response, AuthenticationAPI)> = {
        return self.apiRequests
            .asObservable()
            .flatMap({ apiWrapper -> Observable<(Moya.Response, AuthenticationAPI)> in
                return apiWrapper.elements()
                    .map { ($0, apiWrapper.token)
                    }
            })
            .share()
    }()

    private enum ParseType {
        case signedIn(response: UserResponse)
        case signedOut(response: GenericAPIResponse)
        case parseError(error: Error)
    }

    private lazy var parseEvents: Observable<(ParseType,AuthenticationAPI)> = {
        self.apiRequestResponses
            .observeOn(self.computationScheduler)
            .flatMap { values -> Observable<(ParseType,AuthenticationAPI)> in
                let (apiResponse, token) = values
                let observable: Observable<(ParseType,AuthenticationAPI)>
                switch token {
                case .signIn:
                    do {
                        let response = try apiResponse.mapObject(UserResponse.self)
                        observable = Observable.just((.signedIn(response: response),token))
                    } catch let error {
                        observable = Observable.just((.parseError(error: error),token))
                    }
                case .signOut:
                    do {
                        let response = try apiResponse.mapObject(GenericAPIResponse.self)
                        observable = Observable.just((.signedOut(response: response),token))
                    } catch let error {
                        observable = Observable.just((.parseError(error: error),token))
                    }
                }
                return observable
            }
            .observeOn(MainScheduler.instance)
            .share()
    }()

    private lazy var parseErrors: Observable<Error> = self.parseEvents
        .map { values -> Error? in
            guard case let .parseError(error) = values.0 else { return nil }
            return error
    }
        .unwrap()

    lazy var errors: Observable<Error> = {
        let networkErrors = self.apiRequestErrors
            .map { error,token -> Error in
                return AuthenticationServiceError.networkError(error)
            }
        return Observable.merge(networkErrors, self.parseErrors, self.apiResponseErrors)
    }()

    private lazy var apiResponseErrors: Observable<Error> = self.parseEvents
        .map { parseType,_ -> APIResponseError? in
            switch parseType {
            case let .signedIn(response):
                return response.error
            case let .signedOut(response):
                return response.error
            case .parseError:
                return nil
            }
        }
        .unwrap()
        .map { AuthenticationServiceError.apiResponseError($0) }

    lazy var parsedSignedIn = self.parseEvents
        .flatMap({ parseType,token -> Observable<User> in
            if case let .signedIn(response) = parseType, let user = response.user {
                return Observable.just(user)
            } else {
                return Observable.empty()
            }
        })

    lazy var parsedSignedOut = self.parseEvents
        .flatMap({ parseType,token -> Observable<()> in
            if case let .signedOut(response) = parseType {
                return Observable.just(())
            } else {
                return Observable.empty()
            }
        })

}

private struct UserResponse: Decodable {
    let user: User?
    let error: APIResponseError?

    private enum CodingKey: String {
        case user
        case error
    }

}
