//
//  FeedbackRepository.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

protocol FeedbackSending {
    func sendFeedback() -> AnyPublisher<Channel, Error>
}

struct FeedbackRepository: Retrievable {

    typealias Rqstr = FeedbackRequester
}

extension FeedbackRepository: FeedbackSending {

    func sendFeedback() -> AnyPublisher<Channel, Error> {
        return Rqstr.response(for: Rqstr.postFeedback())
            .decode(type: Channel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
