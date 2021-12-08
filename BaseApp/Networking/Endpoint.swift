//
//  Endpoint.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

// MARK: Declaration

struct Endpoint {

    var path: String
    var queryItems: [URLQueryItem] = []
    var isAuthenticated: Bool = true

}

extension Endpoint {

    var url: URL {
        // TODO: Update `basePath`
        let basePath = ""

        var components = URLComponents(string: Bundle.main.baseURL)!
        components.path = "\(basePath)\(path)"

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

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

// MARK: Constants

// TODO: Declare endpoints here
extension Endpoint {
    
    static var login: Self {
        return Endpoint(path: "/login")
    }

}
