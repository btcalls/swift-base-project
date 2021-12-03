//
//  UserDefaults.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation

extension UserDefaults {

    // TODO: Define keys here
    enum Keys: String {
        case test = "test"
    }

    /// Returns a codable object `T` with the given key.
    /// - Returns: Optional `T` object.
    func getCodable<T: Codable>(forKey key: Keys) -> T? {
        guard let data = object(forKey: key.rawValue) as? Data else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }

    /// Stores a codable object.
    func setCodable<T: Codable>(_ object: T, forKey key: Keys) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }

        set(data, forKey: key.rawValue)
    }

}
