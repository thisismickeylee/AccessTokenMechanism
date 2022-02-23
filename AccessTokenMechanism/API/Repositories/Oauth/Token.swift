//
//  Token.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

struct Token: Codable {

    enum CodingKey: String {
        case token = "access_token"
        case expiresIn = "expires_in"
    }
    let token: String
    let expiresIn: Int
}
