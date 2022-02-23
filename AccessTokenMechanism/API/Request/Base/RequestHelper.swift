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
        OauthRequester.setDefaultOAuthParameters(
            clientId: "0nQUyeVHmylb4WYEzjboRoYyN2DgLMdN",
            clientSecret: "AH0oMziThV9MNBgpOC8iUHBW75n3iF1vR1prxXNZPXSZSNDh3lY8DZ7LGt2pvP-8")
    }
}
