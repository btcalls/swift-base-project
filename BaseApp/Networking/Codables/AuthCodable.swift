//
//  AuthCodable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct LoginRequest: FormEncodable {

    var password: String
    var userName: String

    // TODO: Enter test creds here
    static var testParams: Self {
        return .init(password: "xxx", userName: "xxx")
    }

}

struct LoginResponse: APIResponseDecodable {

    // TODO: Update accordingly

}
