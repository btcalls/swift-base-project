//
//  SLAPIClient.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

// TODO: base API response

import UIKit

enum HTTPMethod {

    case get
    case post(Data?)

}

enum APIError: LocalizedError {

    case decodable
    case network
    case noData
    case request(Error)
    case response(String)

}

extension APIError {

    var errorDescription: String? {
        switch self {
        case .decodable:
            return NSLocalizedString("Failed decoding provided data.",
                                     comment: "Decode Failure")

        case .network:
            return NSLocalizedString("Network is currently offline.",
                                     comment: "Offline Network")

        case .noData:
            return NSLocalizedString("No data available.",
                                     comment: "No Data")

        case .request(let error):
            return error.localizedDescription

        case .response(let message):
            return NSLocalizedString(message, comment: "Response Error")
        }
    }

}

class SLAPIClient: NSObject {

    static let shared: SLAPIClient = SLAPIClient()

}

extension SLAPIClient {

    func get<R: Decodable>(
        type: R.Type,
        endpoint: Endpoint,
        completion: @escaping(Swift.Result<R, APIError>) -> Void
    ) where R: SLAPIResponse {
        request(type: type,
                endpoint: endpoint,
                method: .get,
                completion: completion)
    }

    func post<R: Decodable, F: FormEncodable>(
        type: R.Type,
        endpoint: Endpoint,
        body: F?,
        completion: @escaping(Swift.Result<R, APIError>) -> Void
    ) where R: SLAPIResponse {
        var data: Data?

        if let body = body {
            data = try? CodableTransform.toJSONData(encodable: body)
        }

        request(type: type,
                endpoint: endpoint,
                method: .post(data),
                completion: completion)
    }

    private func request<T: Decodable>(
        type: T.Type,
        endpoint: Endpoint,
        method: HTTPMethod,
        completion: @escaping(Swift.Result<T, APIError>) -> Void
    ) where T: SLAPIResponse {
        printDebug("Sending request to \(endpoint.url.absoluteString)")

        var request = URLRequest(url: endpoint.url)

        switch method {
        case .get:
            request.httpMethod = "GET"

        case .post(let httpBody):
            request.httpMethod = "POST"

            if let httpBody = httpBody {
                if let json = try? httpBody.toJSON() {
                    printDebug("Params: \(json)")
                }

                request.httpBody = httpBody
            }
        }

        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                completion(.failure(.request(error)))
                AppDelegate.shared.presentDialog(type: .error(error))

                return
            }

            guard let data = data, response != nil else {
                completion(.failure(.noData))

                return
            }

            // Debug response
            if let json = try? data.toJSON() {
                printDebug("Response: \(json)")
            }

            // Decode response
            guard let object = try! CodableTransform.toCodable(T.self, data: data) else {
                completion(.failure(.decodable))

                return
            }

            DispatchQueue.main.async {
                // Handle acknowledge
                switch object.acknowledge {
                case .success:
                    completion(.success(object))

                case .failure:
                    completion(.failure(.response(object.responseMessage)))

                case .logout:
                    AppDelegate.shared.logout()
                    completion(.failure(.response(object.responseMessage)))

                case .update:
                    AppDelegate.shared.updateApp()
                    completion(.failure(.response(object.responseMessage)))

                case .logoutAndUpdate:
                    AppDelegate.shared.logout(toUpdate: true)
                    completion(.failure(.response(object.responseMessage)))
                }
            }
        }

        dataTask.resume()
    }

}
