//
//  APIRequester.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

protocol APIRequester: Requester, JSONContentTypeHeaderRequestInserting, OAuthHeaderRequestInserting {
    static var root: String { get }
    static var endpoint: String { get }

    static func preDispatchAction() -> AnyPublisher<Void, Error>?
    static func interceptors() -> [(URLRequest) -> (URLRequest)]?
}

extension APIRequester {

    static var root: String {
        return "https://collect.getfbk.com/v2"
    }

    static func preDispatchAction() -> AnyPublisher<Void, Error>? {
        return Future<Void, Error> { promise in
            RequesterHelper.tokenManager.getValidToken { result in
                switch result {
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    static func interceptors() -> [(URLRequest) -> (URLRequest)]? {
        return [
            addJSONContentTypeHeader,
            addOAuthHeader
        ]
    }
}
