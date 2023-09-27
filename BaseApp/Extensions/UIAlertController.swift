//
//  UIAlertController.swift
//  BaseApp
//
//  Created by Jason Jon Carreos on 19/9/2023.
//  Copyright © 2023 BTCalls. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func loader(message: String = "Please wait...",
                       completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: .init(x: 10,
                                                             y: 5,
                                                             width: 50,
                                                             height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        
        return alert
    }
    
}
