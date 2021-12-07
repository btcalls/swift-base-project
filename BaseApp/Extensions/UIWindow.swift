//
//  UIWindow.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/7/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

extension UIWindow {

    static var key: UIWindow? {
        if #available(iOS 15, *) {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first(where: \.isKeyWindow)
        }

        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first(where: \.isKeyWindow)
        }

        return UIApplication.shared.keyWindow
    }
    
}
