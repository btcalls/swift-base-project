//
//  BaseCodable.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation

enum Acknowledge: Int, Codable {
    case success = 1
    case failure = 0
    case logout = 3
    case update = 5
    case logoutAndUpdate = 6
}

protocol APIResponseDecodable: Decodable {

    var acknowledge: Acknowledge { get set }
    var fullMessage: String { get set }
    var message: String { get set }

}

extension APIResponseDecodable {

    var responseMessage: String {
        return fullMessage.isEmpty ? message : fullMessage
    }

}

struct BaseAPIResponse: APIResponseDecodable {

    var acknowledge: Acknowledge
    var fullMessage: String
    var message: String

}

protocol FormEncodable: Encodable {}

struct AppSidRequest: FormEncodable {

    var appSid: String

    init() {
        guard let appSid: String = UserDefaults.standard.get(.appSid) else {
            preconditionFailure("No valid appSid found.")
        }

        self.appSid = appSid
    }

}
