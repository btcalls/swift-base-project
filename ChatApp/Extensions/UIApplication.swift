//
//  UIApplication.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import UIKit

extension UIApplication {

    /// Tries to open URL from a given string.
    /// - Parameter urlString: The URL string to open.
    func open(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if canOpenURL(url) {
            open(url, options: [:], completionHandler: nil)
        }
    }

}
