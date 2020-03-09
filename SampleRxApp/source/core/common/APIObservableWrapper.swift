//
//  APIObservableWrapper.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya

/**
 A wrapper for Moya API Observables so we can attach some additional information and behavior

 - Note: The observable returned via `asObservable` is shared, so multiple subscriptions
 won't trigger creation or side effects multiple times. Activity is tracked on the incoming
 ActivityIndicator .
 */
public class APIObservableWrapper<T: TargetType>: ObservableConvertibleType {
    /// The source is stored privately in case we want to do anything in particular to the returned observable on the way out
    private let source: Observable<Response>

    /// Provides access to the request token for easy filtering behavior
    public let token: T

    required public init(_ token: T, source: Observable<Moya.Response>, activityIndicator: ActivityIndicator?) {
        self.token = token
        if let activityIndicator = activityIndicator {
            self.source = source
                .trackActivity(activityIndicator)
                // share the underlying observable so multiple API requests aren't made
                .share(replay: 1, scope: .forever)
        } else {
            self.source = source.share(replay: 1, scope: .forever)
        }
    }

    public func asObservable() -> Observable<Response> {
        return source
    }

    /// Returns an observable of errors for the particular request
    public func errors() -> Observable<Error> {
        return source
            .logError(message: "APIError")
            .materialize()
            .errors()
    }

    /// Sends a .next(Moya.Response) or .completed if there is an error
    ///
    /// - Returns: An Observable of Moya responses
    public func elements() -> Observable<Moya.Response> {
        return source
            .catchErrorJustComplete()
            .materialize()
            .elements()
            .take(1)
    }
}

