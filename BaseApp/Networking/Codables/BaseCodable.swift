//
//  BaseCodable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

/// Struct for common API response data.
struct BaseAPIResponse: APIResponseDecodable {

    // TODO: Conform to protocol

}

/// Struct to encapsulate data property of API responses for fetching paginated items.
struct DataContainer<T: Decodable>: Decodable {
    
    let count: Int
    let limit: Int
    let offset: Int
    let total: Int
    let results: [T]
    
}

// NOTE: Marvel API-specific. Remove after.
struct Item: Codable {
    
    var name: String
    var resourceURI: String
    
}

// NOTE: Marvel API-specific. Remove after.
struct ItemContainer: Codable {
    
    var items: [Item]
    
}

// NOTE: Marvel API-specific. Retain for @propertyWrapper sample.
@propertyWrapper
struct Thumbnail: Codable {
    
    private var value: URL?
    
    var wrappedValue: URL? {
        get { return value }
        set { value = newValue }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            value = nil
        } else {
            let dict = try container.decode([String: String].self)
            
            if let path = dict["path"], let ext = dict["extension"] {
                value = URL(string: "\(path).\(ext)")
            } else {
                value = nil
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let value = value {
            let dict = ["extension": value.pathExtension,
                        "path": value.path]
            
            try container.encode(dict)
        } else {
            try container.encodeNil()
        }
    }
    
}

/// Protocol for API or form encodables to be used as parameters or HTTP body data.
protocol FormEncodable: Encodable {}

extension FormEncodable {

    func toJSONData(
        key: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase
    ) throws -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = key

        return try encoder.encode(self)
    }

}
