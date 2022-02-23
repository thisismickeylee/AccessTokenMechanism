//
//  OAuthHeaderRequestInserting.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

protocol OAuthHeaderRequestInserting {
    static func addOAuthHeader(toRequest request: URLRequest) -> URLRequest
}

extension OAuthHeaderRequestInserting {

    static func addOAuthHeader(toRequest request: URLRequest) -> URLRequest {
        var request = request
        guard
            RequesterHelper.tokenManager.tokenIsValid,
            let accessToken = RequesterHelper.tokenManager.token
        else {
            return request
        }
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        return request
    }
}
