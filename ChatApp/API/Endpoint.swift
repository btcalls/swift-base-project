//
//  Endpoint.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
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

// TODO: Declare endpoints here
extension Endpoint {

    static var login: Self {
        return Endpoint(path: "/Login")
    }
    static var threads: Self {
        return Endpoint(path: "/GetAllThread")
    }

}
