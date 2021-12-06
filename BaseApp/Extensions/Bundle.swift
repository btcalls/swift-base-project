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
        let value = object(forInfoDictionaryKey: "SL_APP_CODE") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var appName: String {
        let value = object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var appVersion: String {
        let value = object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var baseURL: String {
        let value = object(forInfoDictionaryKey: "SL_BASE_URL") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var deviceToken: String {
        var token = object(forInfoDictionaryKey: "SL_DEVICE_TOKEN") as! String
        token = token.trimmingCharacters(in: .whitespacesAndNewlines)

        return token.isEmpty ? UIDevice.current.name : token
    }
    var displayAppVersion: String {
        let value = object(forInfoDictionaryKey: "SL_DISPLAY_APP_VERSION") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
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
    var sharedURL: String {
        let value = object(forInfoDictionaryKey: "SL_SHARED_URL") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Prints to console the current app configuration.
    func printConfig() {
        printDebug("""

        App code: \(appCode)
        App version: \(appVersion)
        Device token: \(deviceToken)
        Base URL: \(baseURL)
        Shared URL: \(sharedURL)
        """)
    }

}
