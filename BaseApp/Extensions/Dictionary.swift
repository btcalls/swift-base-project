//
//  Dictionary.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation

extension Dictionary {

    func toJSONString() -> String? {
        if let data = self.toData(),
           let string = String(data: data, encoding: .utf8) {
            return string
        }

        return nil
    }

    func toData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return nil
        }
    }

}
