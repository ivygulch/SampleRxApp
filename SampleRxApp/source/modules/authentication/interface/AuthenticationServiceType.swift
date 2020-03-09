//
//  AuthenticationServiceType.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public enum AuthenticationServiceError: Error {
    case networkError(Error)
    case parsingError(Error)
    case apiResponseError(APIResponseError)
}


public protocol AuthenticationServiceType: ServiceType {
    var isSignedIn: Driver<Bool> { get }
    var user: Driver<User?> { get }

    var dispatcher: ActionDispatcher<AuthenticationAction> { get }
    var errors: Observable<Error> { get }
    var apiResponseErrors: Observable<APIResponseError> { get }
}
