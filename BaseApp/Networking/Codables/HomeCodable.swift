//
//  HomeCodable.swift
//  BaseApp
//
//  Created by Jason Jon Carreos on 4/9/2023.
//  Copyright © 2023 BTCalls. All rights reserved.
//

import Foundation

// NOTE: Marvel API-specific. Remove after.
struct GetCharactersResponse: APIListResponseDecodable {
    
    typealias Item = MarvelCharacter
    
    var copyright: String
    var data: DataContainer<MarvelCharacter>

}

// NOTE: Marvel API-specific. Remove after.
struct GetCharactersRequest: APIRequest {
    
    typealias Response = GetCharactersResponse
    
    var endpoint: Endpoint = .getCharacters()
    var method: HTTPMethod = .get
    
}

// NOTE: Marvel API-specific. Remove after.
struct MarvelCharacter: Codable {
    
    var id: Int
    var name: String
    var description: String
    var modified: Date
    var events: ItemContainer
    var series: ItemContainer
    var comics: ItemContainer
    @Thumbnail var thumbnail: URL?
    
}

// NOTE: Marvel API-specific. Remove after.
extension Endpoint {
    
    static func getCharacters(queryItems: [URLQueryItem] = []) -> Self {
        var items = Self.marvelAPIQueryItems
        
        items.append(contentsOf: queryItems)
        
        return Endpoint(path: "/characterssdfdf", queryItems: items)
    }

}
