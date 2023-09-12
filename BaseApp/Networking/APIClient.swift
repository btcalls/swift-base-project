//
//  APIClient.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod {
    case get
    case post(FormEncodable?)
}

protocol APIRequest {
    
    associatedtype Response: APIResponseDecodable
    
    var endpoint: Endpoint { get set }
    var method: HTTPMethod { get set }
    
}

final class APIClient: NSObject {

    static let shared: APIClient = APIClient()

    var isAuthenticated: Bool {
        // TODO: Implement checking

        return false
    }
    
    func send<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        let urlRequest = getURLRequest(for: request)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { CustomError.custom($0.localizedDescription) }
            .tryMap { [weak self] data , response -> Data in
                if let error = self?.getHttpError(response) {
                    throw error
                }
                
                return data
            }
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
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

    private func getURLRequest<T: APIRequest>(for request: T) -> URLRequest {
        let endpoint = request.endpoint
        var urlRequest = URLRequest(url: endpoint.url)
        
        Debugger.print(endpoint.url.absoluteString)
        
        switch request.method {
        case .get:
            urlRequest.httpMethod = "GET"

        case .post(let encodable):
            urlRequest.httpMethod = "POST"

            if let httpBody = try? encodable?.toJSONData() {
                if let json = try? httpBody.toJSON() {
                    Debugger.print("Params: \(json)")
                }

                urlRequest.httpBody = httpBody
            }
        }

        // Headers
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }

}
