//
//  BaseCodable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

/// Protocol for decodable instances used to encapsulate an API response.
protocol APIResponseDecodable: Decodable {

    // TODO: Add common response data properties

}

/// Struct for common API response data.
struct BaseAPIResponse: APIResponseDecodable {

    // TODO: Conform to protocol

}

/// Protocol for API or form encodables to be used as parameters or HTTP body data.
protocol FormEncodable: Encodable {}

extension FormEncodable {

    func toJSONData() throws -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .toUpperCamelCase

        return try encoder.encode(self)
    }

}
