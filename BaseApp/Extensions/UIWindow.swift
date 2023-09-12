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
        return UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first
    }
    
}
