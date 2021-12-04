//
//  BaseCodable.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation

protocol FormEncodable: Encodable {}

protocol SLAPIResponse {

    var acknowledge: Acknowledge { get set }
    var fullMessage: String { get set }
    var message: String { get set }

}

struct AppSidRequest: FormEncodable {

    var appSid: String

    static var defaultValue: Self {
        guard let appSid: String = UserDefaults.standard.get(.appSid) else {
            preconditionFailure("No valid appSid found.")
        }

        return .init(appSid: appSid)
    }

}
