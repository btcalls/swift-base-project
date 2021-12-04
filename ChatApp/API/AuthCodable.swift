//
//  AuthCodable.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation

enum Acknowledge: Int, Codable {

    case failure = 0
    case success = 1
    case logout = 3
    case update = 5
    case logoutAndUpdate = 6

}

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
        return .init(password: "shamelesszzz", userName: "KYHECzzz")
    }

}

struct LoginResponse: Decodable, SLAPIResponse {

    var acknowledge: Acknowledge
    var fullMessage: String
    var message: String
    var appSid: String
    var securityLevel: Int = 1

}
