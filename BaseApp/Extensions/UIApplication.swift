//
//  UIApplication.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

extension UIApplication {

    func open(_ urlString: String) throws {
        let error: CustomError = .app(.appOpenError)
        
        guard let url = URL(string: urlString) else {
            throw error
        }

        guard canOpenURL(url) else {
            throw error
        }
        
        open(url, options: [:], completionHandler: nil)
    }

}
