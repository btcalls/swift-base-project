//
//  HomeCodable.swift
//  BaseApp
//
//  Created by Jason Jon Carreos on 4/9/2023.
//  Copyright © 2023 BTCalls. All rights reserved.
//

import Foundation

struct GetCharactersResponse: APIResponseDecodable {

    // TODO: Update accordingly

}

struct GetCharactersRequest: APIRequest {
    
    typealias Response = GetCharactersResponse
    
    var endpoint: Endpoint = .getCharacters
    var method: HTTPMethod = .get
    
}

extension Endpoint {
    
    static var getCharacters: Self {
        let timestamp = Date().timeIntervalSince1970
        let publicKey = Bundle.main.apiKey
        let privateKey = Bundle.main.apiPrivateKey
        let hash = "\(timestamp)\(privateKey)\(publicKey)".toMD5()
        
        return Endpoint(path: "/characters",
                        queryItems: [.init(name: "ts", value: "\(timestamp)"),
                                     .init(name: "apikey", value: publicKey),
                                     .init(name: "hash", value: hash)])
    }

}
