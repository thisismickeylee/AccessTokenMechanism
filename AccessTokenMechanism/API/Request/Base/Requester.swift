//
//  Requester.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

enum RequestError: Error {
    case constructUrlFailed
}

protocol Requester {
    static var root: String { get }
    static var endpoint: String { get }

    static func preDispatchAction() -> AnyPublisher<Void, Error>?
    static func interceptors() -> [(URLRequest) -> (URLRequest)]?
}

extension Requester {

    static func response(for request: URLRequest) -> AnyPublisher<Data, Error> {
        var interceptedAction: AnyPublisher<Data, Error> {
            let request = Self.applyInterceptors(request: request)
            let dispatcher = RequestDispatcher(request: request)
            return dispatcher.dispatch()
        }
        // If we have a pre-dispatch action,
        // we wrap the original request in that action. If not, we just return the original action.
        if let preDispatchAction = Self.preDispatchAction() {
            // This means that we'll wait for the pre-dispatch action to complete,
            // then perform the original request (in this case called interceptedAction).
            return preDispatchAction.flatMap { _ in
                return interceptedAction
            }
            .eraseToAnyPublisher()
        } else {
            return interceptedAction
        }
    }

    static func applyInterceptors(request: URLRequest) -> URLRequest {
        var request = request
        if let interceptors = Self.interceptors() {
            for interceptor in interceptors {
                request = interceptor(request)
            }
        }
        return request
    }
}
