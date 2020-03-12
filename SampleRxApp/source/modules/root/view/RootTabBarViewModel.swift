//
//  RootTabBarViewModel.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RootTabBarViewModelType {
    var viewControllers: Driver<[UIViewController]> { get }
}

struct RootTabBarViewModel: RootTabBarViewModelType {
    let viewControllers: Driver<[UIViewController]>

    init(isSignedIn: Driver<Bool>, signedInCoordinators: [CoordinatorType], signedOutCoordinators: [CoordinatorType]) {
        viewControllers = isSignedIn.map {
            if $0 {
                return signedInCoordinators.map { $0.mainViewController }
            } else {
                return signedOutCoordinators.map { $0.mainViewController }
            }
        }
    }

}
