//
//  AuthenticationAPI+mock.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import Foundation
import Moya

extension AuthenticationAPI {

    public static func stubbedProvider() -> MoyaProvider<AuthenticationAPI> {
        let endpointClosure = { (target: AuthenticationAPI) -> Endpoint in
            let responseClosure: () -> EndpointSampleResponse
            switch target {
            case let .signIn(username, password):
                if username == password {
                    responseClosure = EndpointSampleResponse.mockResponseClosure(resourceName: "mockSigninSuccess.json")
                } else {
                    responseClosure = EndpointSampleResponse.mockResponseClosure(statusCode: 401, resourceName: "mockSigninFailure.json")
                }
            case .signOut:
                responseClosure = EndpointSampleResponse.mockResponseClosure(resourceName: "mockSignoutSuccess.json")
            }
          return Endpoint(url: URL(target: target).absoluteString,
                          sampleResponseClosure: responseClosure,
                          method: target.method,
                          task: target.task,
                          httpHeaderFields: target.headers)
        }
        return MoyaProvider<AuthenticationAPI>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

}
