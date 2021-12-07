//
//  UIViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/7/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAsModal(_ vc: UIViewController,
                        animated: Bool,
                        completion: (() -> Void)? = nil) {
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .formSheet

        present(vc, animated: true, completion: nil)
    }

}
