//
//  ActionDispatcher.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

public protocol ActionDispatchAction {}

// Currently just a simple wrapper around a publish subject
public class ActionDispatcher<ActionType: ActionDispatchAction> {
    let subject = PublishSubject<ActionType>()
    public lazy var actions: Observable<ActionType> = self.subject

    public func dispatch(_ action: ActionType) {
        self.subject.onNext(action)
    }
}
