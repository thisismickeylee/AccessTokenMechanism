//
//  RequestHelper.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

struct RequesterHelper {

    static var tokenManager: OauthTokenManager!

    static func setupAPI() {
        let tokenRepository = OauthRepository()
        let authorisationStore = AuthorisationStore()
        tokenManager = OauthTokenManager(tokenRepository: tokenRepository, authorisationStore: authorisationStore)
        OauthRequester.setDefaultOAuthParameters(clientId: "", clientSecret: "")
    }
}
