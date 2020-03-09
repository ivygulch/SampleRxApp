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
    case requiredComponent(String)
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

    func resolveRequired<T>(_ type: T.Type) throws -> T {
        guard let result = resolve(type) else {
            throw AppContainerError.requiredComponent(String(describing: type))
        }
        return result
    }

}
