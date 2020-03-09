//
//  SampleApplicationDelegate.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import Swinject

public class SampleRxAppApplicationDelegate: NSObject, UIApplicationDelegate {

    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadAssemblies()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppContainer.shared.rootCoordinator.mainViewController
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: - private methods

    private func loadAssemblies() {
        let assemblies = [
            RootModule.assembly,
            HomeModule.assembly,
            AuthenticationModule.assembly,
        ]
        AppContainer.shared.assembler.apply(assemblies: assemblies)
    }

}
