//
//  OauthTokenManageable.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

protocol OauthTokenManageable {
    var token: String? { get }
    var tokenIsValid: Bool { get }

    func getValidToken(_: @escaping (Result<Void, Error>) -> Void)
}

final class OauthTokenManager: OauthTokenManageable {

    var token: String? { authorisationStore.accessToken }
    var tokenIsValid: Bool { authorisationStore.accessTokenValid }

    private let tokenRepository: OauthProviding
    private let authorisationStore: AuthorisationStoring
    private var getTokenPublisher: AnyCancellable?

    init(
        tokenRepository: OauthProviding,
        authorisationStore: AuthorisationStoring
    ) {
        self.tokenRepository = tokenRepository
        self.authorisationStore = authorisationStore
    }

    func getValidToken(_ completion: @escaping (Result<Void, Error>) -> Void) {
        guard !tokenIsValid else {
            return completion(.success(()))
        }
        getTokenPublisher = tokenRepository.requestToken()
            .sink(receiveCompletion: { [weak self] complete in
                if case let .failure(error) = complete {
                    self?.removeCredentials()
                    completion(.failure(error))
                }
            }, receiveValue: { [weak self] in
                self?.storeCredentials(accessToken: $0.token, expiresIn: $0.expiresIn)
                completion(.success(()))
            })
    }

    private func storeCredentials(accessToken: String, expiresIn: Int) {
        authorisationStore.saveCredentials(
            token: accessToken,
            secondsExpiresIn: expiresIn)
    }

    private func removeCredentials() {
        authorisationStore.removeCredentials()
    }
}
