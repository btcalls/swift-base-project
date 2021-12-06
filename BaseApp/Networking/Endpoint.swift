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

}

extension Endpoint {

    var url: URL {
        // TODO: Update `basePath`
        let basePath = "ChatService.svc"

        var components = URLComponents(string: Bundle.main.baseURL)!
        components.path = "\(Bundle.main.sharedURL)\(basePath)\(path)"

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
    var headers: [String: Any] {
        return [
            "Content-Type": "application/json; charset=utf-8;"
        ]
    }

}

// MARK: Constants

extension Endpoint {
    // TODO: Declare endpoints here
    static var login: Self {
        return Endpoint(path: "/Login")
    }
    static var logout: Self {
        return Endpoint(path: "/Logout")
    }

}
