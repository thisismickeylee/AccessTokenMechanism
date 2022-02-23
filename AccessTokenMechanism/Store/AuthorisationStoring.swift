//
//  AuthorisationStoring.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

/// Used to store authorisation tokens
protocol AuthorisationStoring {
    var accessToken: String? { get }
    var accessTokenValid: Bool { get }

    func saveCredentials(token: String, secondsExpiresIn: Int)
    func removeCredentials()
}

/// Implements a secure (keychain based) storage for token storage
struct AuthorisationStore: AuthorisationStoring {

    enum KeychainKey: String {
        case token = "photobox-token"
        case expiryDate = "photobox-tokenExpiryDate"
    }

    private let keychain: KeychainSwift

    init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }

    var accessToken: String? {
        return keychain.get(KeychainKey.token.rawValue)
    }

    var accessTokenValid: Bool {
        return expiryDateValid(expiryDateString: keychain.get(KeychainKey.expiryDate.rawValue))
    }

    func saveCredentials(token: String, secondsExpiresIn: Int) {
        update(accessToken: token, withSecondsExpiresIn: secondsExpiresIn)
    }

    func removeCredentials() {
        keychain.delete(KeychainKey.token.rawValue)
        keychain.delete(KeychainKey.expiryDate.rawValue)
    }

    private func update(accessToken: String, withSecondsExpiresIn seconds: Int) {
        let expiryDate = "\(Date().addingTimeInterval(Double(seconds)).toMilliseconds())"
        keychain.set(accessToken, forKey: KeychainKey.token.rawValue)
        keychain.set(expiryDate, forKey: KeychainKey.expiryDate.rawValue)
    }

    private func expiryDateValid(expiryDateString: String?) -> Bool {
        guard let expiryDateString = expiryDateString, let timestamp = Int64(expiryDateString) else { return false }
        return Date().toMilliseconds() < timestamp
    }
}

private extension Date {

    func toMilliseconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
