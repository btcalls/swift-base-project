//
//  AuthCodable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct LoginBody: FormEncodable {
    
    var username: String
    var password: String

    // TODO: Enter test creds here
    static var testParams: Self {
        return .init(username: "xxx", password: "xxx")
    }

}

struct LoginResponse: APIResponseDecodable {

    // NOTE: Sample
    var token: String
    var email: String

}

struct LoginRequest: APIRequest {
    
    typealias Response = LoginResponse
    
    var endpoint: Endpoint = .init(path: "/login")
    var method: HTTPMethod
    
}
