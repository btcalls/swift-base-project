//
//  Data.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/4/21.
//  Copyright © 2021 Slomins. All rights reserved.
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
