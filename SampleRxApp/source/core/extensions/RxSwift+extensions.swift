//
//  RxSwift+extensions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import os.log

public extension RxSwift.ObservableType {

    func logError(message: String = "", type: OSLogType = .default, log: OSLog = OSLog.default) -> Observable<E> {
        return self.do(onError: { error throws -> Void in
            let errorMessage = "\(error)" // ensure we get a useful error message for things like enums
            os_log("%{public}@Observable error: %{public}@. %{public}@", log: log, type: type, message, error.localizedDescription, errorMessage)
        })
    }

}
