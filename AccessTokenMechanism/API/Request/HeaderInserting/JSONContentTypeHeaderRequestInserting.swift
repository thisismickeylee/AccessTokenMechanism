//
//  JSONContentTypeHeaderRequestInserting.swift
//  AccessTokenMechanism
//
//  Created by Mickey Lee on 23/02/2022.
//

import Foundation

protocol JSONContentTypeHeaderRequestInserting {
    static func addJSONContentTypeHeader(toRequest request: URLRequest) -> URLRequest
}

extension JSONContentTypeHeaderRequestInserting {

    static func addJSONContentTypeHeader(toRequest request: URLRequest) -> URLRequest {
        var request = request
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
