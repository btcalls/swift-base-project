//
//  APIClient.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

enum HTTPMethod {
    case get
    case post(FormEncodable?)
}

class APIClient: NSObject {

    static let shared: APIClient = APIClient()

    var isAuthenticated: Bool {
        guard let appSid: String = UserDefaults.standard.get(.appSid) else {
            return false
        }

        return !appSid.isEmpty
    }

    func request<R: APIResponseDecodable>(
        to endpoint: Endpoint,
        method: HTTPMethod,
        responseType type: R.Type,
        completion: @escaping(Swift.Result<R, CustomError>) -> Void
    ) {
        let request = getRequest(for: endpoint, method: method)

        executeRequest(type: type, request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    ViewPresenter.presentAlert(.error(error))

                default:
                    break
                }

                completion(result)
            }
        }
    }
    
    private func getHttpError(_ response: URLResponse?) -> CustomError? {
        guard let response = response as? HTTPURLResponse else {
            return .network(.failed)
        }

        switch response.statusCode {
        case 200...299:
            return nil

        case 401...500:
            return .network(.authError)

        case 501...599:
            return .network(.badRequest)

        default:
            return .network(.failed)
        }
    }

    private func getRequest(for endpoint: Endpoint, method: HTTPMethod) -> URLRequest {
        printDebug("Request to \(endpoint.url.absoluteString)")

        var request = URLRequest(url: endpoint.url)

        switch method {
        case .get:
            request.httpMethod = "GET"

        case .post(let encodable):
            request.httpMethod = "POST"

            if let httpBody = try? encodable?.toJSONData() {
                if let json = try? httpBody.toJSON() {
                    printDebug("Params: \(json)")
                }

                request.httpBody = httpBody
            }
        }

        // Headers
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }

    private func executeRequest<T: APIResponseDecodable>(
        type: T.Type,
        request: URLRequest,
        completion: @escaping(Swift.Result<T, CustomError>) -> Void
    ) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                let customError: CustomError = .custom(error.localizedDescription)

                printDebug("Error: \(customError.localizedDescription)")
                completion(.failure(customError))

                return
            }

            guard let data = data, response != nil else {
                completion(.failure(.network(.noData)))

                return
            }

            // Check HTTP response
            if let httpError = self.getHttpError(response) {
                printDebug("HTTP Error: \(httpError.localizedDescription)")
                completion(.failure(httpError))

                return
            }

            // Debug response
            if let json = try? data.toJSON() {
                printDebug("JSON Response: \(json)")
            }

            // Decode response
            guard let object = try? CodableTransform.toCodable(T.self, data: data) else {
                let networkError: CustomError = .network(.decodeError)

                printDebug("Network Error: \(networkError.localizedDescription)")
                completion(.failure(networkError))

                return
            }

            // Handle acknowledge
            if object.acknowledge == .success {
                completion(.success(object))

                return
            }

            let responseError: CustomError = .custom(object.responseMessage)

            switch object.acknowledge {
            case .logout:
                AppDelegate.shared.logout()

            case .update:
                AppDelegate.shared.updateApp()

            case .logoutAndUpdate:
                AppDelegate.shared.logout(toUpdate: true)

            default:
                break
            }

            printDebug("Response Error: \(responseError)")
            completion(.failure(responseError))
        }

        dataTask.resume()
    }

}
