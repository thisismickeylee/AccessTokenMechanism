//
//  TokenRepository.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

protocol OauthProviding {
    func requestToken() -> AnyPublisher<Token, Error>
}

struct OauthRepository: Retrievable {

    typealias Rqstr = OauthRequester
}

extension OauthRepository: OauthProviding {

    func requestToken() -> AnyPublisher<Token, Error> {
        return Rqstr.response(for: Rqstr.requestAccessToken())
            .decode(type: Token.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
