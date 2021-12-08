//
//  MainViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction private func onLogoutClick(_ sender: Any) {
        AppDelegate.shared.logout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
