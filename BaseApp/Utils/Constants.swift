//
//  Constants.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

enum DialogType {
    case custom(title: String, message: String)
    case error(CustomError)
}

enum CustomError: LocalizedError {
    case network(NetworkResponse)
    case custom(String)
}

enum NetworkResponse: String {
    case authError = "Request needs to be authenticated."
    case badRequest = "Bad request."
    case failed = "Network request failed."
    case offline = "Network is offline."
    case noData = "Response returned with no data to decode."
    case decodeError = "Could not decode response."
}

extension CustomError {

    var errorDescription: String? {
        switch self {
        case .network(let message):
            return NSLocalizedString(message.rawValue, comment: "Network Error")


        case .custom(let message):
            return NSLocalizedString(message, comment: "Error")
        }
    }

}
