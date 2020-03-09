//
//  AuthenticationAction.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation

public enum AuthenticationAction: ActionDispatchAction, Equatable {
    case signIn(username: String, password: String)
    case signOut
}
