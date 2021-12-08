//
//  Bundle.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {

    // MARK: User-Defined Build Settings

    var appName: String {
        let value = object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var appVersion: String {
        let value = object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var baseURL: String {
        let value = object(forInfoDictionaryKey: "UD_BASE_URL") as! String

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var displayAppVersion: String {
        let value = object(forInfoDictionaryKey: "UD_DISPLAY_APP_VERSION") as! String

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

    /// Prints to console the current app configuration.
    func printConfig() {
        Debugger.print("""

        App version: \(appVersion)
        Base URL: \(baseURL)
        """)
    }

}
