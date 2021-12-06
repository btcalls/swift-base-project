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

class SLAPIClient: NSObject {

    static let shared: SLAPIClient = SLAPIClient()

    var isAuthenticated: Bool {
        guard let appSid: String = UserDefaults.standard.get(.appSid) else {
            return false
        }

        return !appSid.isEmpty
    }

}

extension SLAPIClient {

    func get<R: APIResponseDecodable>(
        type: R.Type,
        endpoint: Endpoint,
        completion: @escaping(Swift.Result<R, SLError>) -> Void
    ) {
        request(type: type,
                endpoint: endpoint,
                method: .get,
                completion: completion)
    }

    func post<R: APIResponseDecodable, F: FormEncodable>(
        type: R.Type,
        endpoint: Endpoint,
        body: F?,
        completion: @escaping(Swift.Result<R, SLError>) -> Void
    ) {
        var data: Data?

        if let body = body {
            data = try? CodableTransform.toJSONData(encodable: body)
        }

        request(type: type,
                endpoint: endpoint,
                method: .post(data),
                completion: completion)
    }

    private func request<T: APIResponseDecodable>(
        type: T.Type,
        endpoint: Endpoint,
        method: HTTPMethod,
        completion: @escaping(Swift.Result<T, SLError>) -> Void
    ) {
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

        printDebug("Sending request to \(endpoint.url.absoluteString)")

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                let customError: SLError = .custom(error.localizedDescription)

                printDebug("Error: \(customError.localizedDescription)")
                completion(.failure(customError))
                AppDelegate.shared.presentDialog(type: .error(customError))

                return
            }

            guard let data = data, response != nil else {
                completion(.failure(.network(.noData)))

                return
            }

            // Check HTTP response
            let httpResponse = response as! HTTPURLResponse
            var httpError: SLError?

            switch httpResponse.statusCode {
            case 200...299:
                fallthrough

            case 401...500:
                httpError = .network(.authError)

            case 501...599:
                httpError = .network(.badRequest)

            default:
                httpError = .network(.failed)
            }

            if let httpError = httpError {
                printDebug("Error: \(httpError.localizedDescription)")
                completion(.failure(httpError))

                return
            }

            // Debug response
            if let json = try? data.toJSON() {
                printDebug("JSON Response: \(json)")
            }

            // Decode response
            guard let object = try! CodableTransform.toCodable(T.self, data: data) else {
                let networkError: SLError = .network(.decodeError)

                printDebug("Error: \(networkError.localizedDescription)")
                completion(.failure(networkError))

                return
            }

            DispatchQueue.main.async {
                // Handle acknowledge
                if object.acknowledge == .success {
                    completion(.success(object))

                    return
                }

                let responseError: SLError = .custom(object.responseMessage)

                switch object.acknowledge {
                case .failure:
                    AppDelegate.shared.presentDialog(type: .error(responseError))

                case .logout:
                    AppDelegate.shared.logout()

                case .update:
                    AppDelegate.shared.updateApp()

                case .logoutAndUpdate:
                    AppDelegate.shared.logout(toUpdate: true)

                default:
                    break
                }

                printDebug("Error: \(responseError)")
                completion(.failure(responseError))
            }
        }

        dataTask.resume()
    }

}
