//
//  Endpoint.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct Endpoint {

    var path: String
    var queryItems: [URLQueryItem]?
    var isAuthenticated: Bool = true

}

extension Endpoint {

    // NOTE: Marvel API-specific. Remove after.
    static var marvelAPIQueryItems: [URLQueryItem] {
        let timestamp = Date().timeIntervalSince1970
        let publicKey = Bundle.main.apiKey
        let privateKey = Bundle.main.apiPrivateKey
        let hash = "\(timestamp)\(privateKey)\(publicKey)".toMD5()
        
        return [.init(name: "ts", value: "\(timestamp)"),
                .init(name: "apikey", value: publicKey),
                .init(name: "hash", value: hash)]
    }
    
    var url: URL {
        let basePath = "/v1/public"

        var components = URLComponents(string: Bundle.main.baseURL)!
        components.path = "\(basePath)\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
    var headers: [String: Any] {
        var values: [String: String] = [
            "Content-Type": "application/json; charset=utf-8;"
        ]

        if isAuthenticated, let token: String = UserDefaults.standard.get(.accessToken) {
            values["Authorization"] = "Bearer \(token)"
        }

        return values
    }

}
