//
//  Codable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct CodableTransform {

    static func toJSONData<T: Encodable>(encodable: T) throws -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .toUpperCamelCase

        return try encoder.encode(encodable)
    }

    static func toCodable<T: Decodable>(_ type: T.Type, data: Data) throws -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .toLowerCamelCase

        return try decoder.decode(type, from: data)
    }

}
