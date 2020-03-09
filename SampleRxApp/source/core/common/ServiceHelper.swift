//
//  ServiceHelper.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift

internal class ServiceHelper<T: ServiceType> {
    private let serviceStateSubject = ReplaySubject<ServiceState>.createUnbounded()
    internal lazy var serviceStateObservable: Observable<ServiceState> = serviceStateSubject.asObservable()
        .debug("ServiceType<\(serviceType)>")
    private let serviceType: T.Type

    init(serviceType: T.Type) {
        self.serviceType = serviceType
        serviceStateSubject.onNext(.started)
    }

    deinit {
        serviceStateSubject.onNext(.dismissed)
        serviceStateSubject.onCompleted()
    }

    /// This should be called once the service using the helper is finished initializing itself
    func setInitialized() {
        serviceStateSubject.onNext(.initialized)
    }

}
