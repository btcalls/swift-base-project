//
//  MainViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()

    @IBAction private func onLogoutClick(_ sender: Any) {
        AppDelegate.shared.logout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APIClient.shared.send(GetCharactersRequest())
            .sink { completion in
                switch completion {
                case .failure(let error):
                    Debugger.print(error)

                case .finished:
                    Debugger.print("Success")
                }
            } receiveValue: { response in
                Debugger.print(response)
            }
            .store(in: &cancellable)
    }

}
