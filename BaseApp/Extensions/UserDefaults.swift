//
//  UserDefaults.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

extension UserDefaults {

    enum Keys: String {
        // TODO: Define keys here
        case accessToken = "accessToken"
    }

    func get<T>(_ key: Keys) -> T? {
        return value(forKey: key.rawValue) as? T
    }

    func set(_ value: Any, forKey key: Keys) {
        set(value, forKey: key.rawValue)
        synchronize()
    }

    func remove(_ key: Keys) {
        removeObject(forKey: key.rawValue)
        synchronize()
    }

    func getCodable<T: Codable>(_ key: Keys) -> T? {
        guard let data = object(forKey: key.rawValue) as? Data else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }

    func setCodable<T: Codable>(_ object: T, forKey key: Keys) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }

        set(data, forKey: key.rawValue)
        synchronize()
    }

}
