//
//  FeedbackRequester.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

struct FeedbackRequester: APIRequester {

    static let endpoint: String = "/feedback"
}

extension FeedbackRequester {

    static func postFeedback() -> URLRequest {
        RequestCreator.createRequest(
            withRoot: root,
            andEndpoint: endpoint,
            httpMethod: .POST)
    }
}
