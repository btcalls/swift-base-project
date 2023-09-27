//
//  Codable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct CodableTransform {

    static func toJSONData<T: Encodable>(
        encodable: T,
        key: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase
    ) throws -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = key

        return try encoder.encode(encodable)
    }

    static func toCodable<T: Decodable>(
        _ type: T.Type, data: Data,
        key: JSONDecoder.KeyDecodingStrategy = .toLowerCamelCase
    ) throws -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = key

        return try decoder.decode(type, from: data)
    }

}
