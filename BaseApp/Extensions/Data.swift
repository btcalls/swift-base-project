//
//  Data.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

extension Data {

    func toJSON() throws -> [String: Any]? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) {
            return json as? [String: Any]
        }

        return nil
    }

}
