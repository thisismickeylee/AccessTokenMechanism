//
//  OauthRequester.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

struct OauthRequester: Requester, JSONContentTypeHeaderRequestInserting {

    static let root: String = "https://getfeedback.eu.auth0.com"
    static let endpoint: String = "/oauth/token"

    private static var defaultOAuthParameters: [String: Any] = [:]

    // Must be called during setup. Provides secrets for getting initial access token.
    static func setDefaultOAuthParameters(clientId: String, clientSecret: String) {
        defaultOAuthParameters = [
            "client_id": clientId,
            "client_secret": clientSecret
        ]
    }

    // MARK: - Implementing Requester

    static func preDispatchAction() -> AnyPublisher<Void, Error>? { return nil }

    static func interceptors() -> [(URLRequest) -> (URLRequest)]? {
        return [addJSONContentTypeHeader]
    }

    static func requestAccessToken() -> URLRequest {
        var parameters = defaultOAuthParameters
        parameters["grant_type"] = "client_credentials"
        let request = RequestCreator.createRequest(
            withRoot: root,
            andEndpoint: endpoint,
            httpMethod: .POST,
            body: parameters)
        return Self.applyInterceptors(request: request)
    }
}
