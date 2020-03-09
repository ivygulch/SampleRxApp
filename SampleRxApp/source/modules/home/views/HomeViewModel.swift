//
//  HomeViewModel.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum HomeViewState {
    case showSignInForm
    case showUserForm
}

protocol HomeViewModelType {
    var username: Driver<String?> { get }
    var displayName: Driver<String?> { get }
    var signInErrorMessage: Driver<String?> { get }
    var viewState: Driver<HomeViewState> { get }
}

struct HomeViewModel: HomeViewModelType {
    let username: Driver<String?>
    let displayName: Driver<String?>
    let signInErrorMessage: Driver<String?>
    let viewState: Driver<HomeViewState>

    init(user: Driver<User?>, apiResponseErrors: Driver<APIResponseError?>, isSignedIn: Driver<Bool>) {
        username = user.map { $0?.username }
        displayName = user.map {
            guard let user = $0 else { return nil }
            return user.firstName + " " + user.lastName
        }
        signInErrorMessage = apiResponseErrors
            .map { $0?.message }
            .startWith(nil)
        viewState = isSignedIn.map { $0 ? .showUserForm : .showSignInForm }
    }

}
