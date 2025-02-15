//
//  Constants.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

enum CustomError: LocalizedError {
    case network(NetworkResponse)
    case app(AppResponse)
    case error(Error)
    case custom(String)
}

enum DialogType {
    case custom(title: String, message: String)
    case error(Error)
}

enum NetworkResponse: String {
    case authError = "Request needs to be authenticated."
    case badRequest = "Bad request."
    case failed = "Network request failed."
    case offline = "Network is offline."
    case noData = "Response returned with no data to decode."
    case decodeError = "Could not decode response."
}

enum AppResponse: String {
    case appOpenError = "App cannot open specified URL."
}

enum PermissionType: String {
    case notifications = "Notifications capability is required to receive latest updates."
    case location = "Locations capability is required to keep track of current location."
}

extension CustomError {

    var errorDescription: String? {
        switch self {
        case .network(let message):
            return NSLocalizedString(message.rawValue, comment: "Network Error")

        case .app(let message):
            return NSLocalizedString(message.rawValue, comment: "App Error")
            
        case .error(let error):
            return NSLocalizedString(error.localizedDescription, comment: "Error")
            
        case .custom(let message):
            return NSLocalizedString(message, comment: "Error")
        }
    }

}
