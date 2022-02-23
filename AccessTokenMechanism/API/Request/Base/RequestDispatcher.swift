//
//  RequestDispatcher.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation
import Combine

struct RequestDispatcher {

    let request: URLRequest
    let session: URLSession

    init(
        request: URLRequest,
        session: URLSession = .shared
    ) {
        self.request = request
        self.session = session
    }

    func dispatch() -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .eraseToAnyPublisher()
    }
}
