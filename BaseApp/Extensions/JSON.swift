//
//  JSON.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

private struct AnyKey: CodingKey {

    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }

}

extension JSONDecoder.KeyDecodingStrategy {

    static var toLowerCamelCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { (keys) -> CodingKey in
            let key = keys.last!

            guard key.intValue == nil else {
                return key
            }

            let value = "\(key.stringValue.prefix(1).lowercased())\(key.stringValue.dropFirst())"

            return AnyKey(stringValue: value)!
        }
    }

}

extension JSONEncoder.KeyEncodingStrategy {

    static var toUpperCamelCase: JSONEncoder.KeyEncodingStrategy {
        return .custom { (keys) -> CodingKey in
            let key = keys.last!

            guard key.intValue == nil else {
                return key
            }

            let value = "\(key.stringValue.prefix(1).uppercased())\(key.stringValue.dropFirst())"

            return AnyKey(stringValue: value)!
        }
    }

}
