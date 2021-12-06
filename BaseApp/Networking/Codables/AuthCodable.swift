//
//  AuthCodable.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

struct LoginRequest: FormEncodable {

    var appCode: String = Bundle.main.appCode
    var appVersion: String = Bundle.main.appVersion
    var deviceToken: String = Bundle.main.deviceToken
    var isKeepLogin = true
    var latitude: Double = 0
    var longitude: Double = 0
    var password: String
    var userName: String

    // TODO: Enter test creds here
    static var testParams: Self {
        return .init(password: "shameless", userName: "KYHEC")
    }

}

struct LoginResponse: APIResponseDecodable {

    var acknowledge: Acknowledge
    var fullMessage: String
    var message: String
    var appSid: String
    var securityLevel: Int = 1

}
