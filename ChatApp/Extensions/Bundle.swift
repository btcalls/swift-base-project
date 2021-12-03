//
//  Bundle.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {

    // MARK: User-Defined Build Settings

    var appCode: String {
        return object(forInfoDictionaryKey: "SL_APP_CODE") as! String
    }
    var appVersion: String {
        return object(forInfoDictionaryKey: "SL_APP_VERSION") as! String
    }
    var deviceToken: String {
        let token = object(forInfoDictionaryKey: "SL_DEVICE_TOKEN") as! String

        return token.isEmpty ? UIDevice.current.name : token
    }
    var isProduction: Bool {
        #if DEBUG
        return false
        #elseif QA
        return false
        #else
        return true
        #endif
    }
    var serviceURL: URL {
        let url = object(forInfoDictionaryKey: "SL_SERVICE_URL") as! String

        return URL(string: url)!
    }

    /// Prints to console the current app configuration.
    func printConfig() {
        printDebug("""

            App code: \(appCode)
            App version: \(appVersion)
            Device token: \(deviceToken)
            Service URL: \(serviceURL.absoluteString)
        """)
    }

}
