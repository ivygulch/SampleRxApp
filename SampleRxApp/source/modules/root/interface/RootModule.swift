//
//  RootModule.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

public class RootModule: AssemblyProviderType {
    public static let assembly: Assembly = RootModuleAssembly()
}
