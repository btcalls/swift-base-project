//
//  String.swift
//  BaseApp
//
//  Created by Jason Jon Carreos on 4/9/2023.
//  Copyright © 2023 BTCalls. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    
    func toMD5() -> String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
