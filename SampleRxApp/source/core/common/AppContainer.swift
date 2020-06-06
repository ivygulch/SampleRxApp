//
//  AppContainer.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Swinject

enum AppContainerError: Error {
    case generic(String)
}

public class AppContainer: NSObject {
    public static let shared = AppContainer()

    public let assembler: Assembler
    public let resolver: Resolver

    private let container: Container

    override init() {
        self.container = Container()
        self.assembler = Assembler(container: self.container)
        self.resolver = self.container.synchronize()

        super.init()
    }
}

extension Swinject.Resolver {

    func resolveRequired<Service>(_ serviceType: Service.Type) -> Service {
        return resolve(serviceType)!
    }

    func resolveRequired<Service>(_ serviceType: Service.Type, name: String?) -> Service {
        return resolve(serviceType, name: name)!
    }

    func resolveRequired<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        return resolve(serviceType, argument: argument)!
    }

    func resolveRequired<Service, Arg1>(_ serviceType: Service.Type, name: String?, argument: Arg1) -> Service {
        return resolve(serviceType, name: name, argument: argument)!
    }

    func resolveRequired<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        return resolve(serviceType, arguments: arg1, arg2)!
    }

    func resolveRequired<Service, Arg1, Arg2>(_ serviceType: Service.Type, name: String?, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        return resolve(serviceType, name: name, arguments: arg1, arg2)!
    }

}
