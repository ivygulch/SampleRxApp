//
//  HomeViewActions.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation

protocol HomeViewActionsType {
    func signIn(username: String?, password: String?)
    func signOut()
}

struct HomeViewActions: HomeViewActionsType {
    let signInAction: (_ username: String?, _ password: String?) -> Void
    let signOutAction: () -> Void

    func signIn(username: String?, password: String?) {
        signInAction(username, password)
    }

    func signOut() {
        signOutAction()
    }

}
