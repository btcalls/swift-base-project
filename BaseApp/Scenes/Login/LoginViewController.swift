//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

class LoginViewController: UIViewController, ViewController {

    typealias ViewModel = LoginViewModel

    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.viewModel.delegate = self
    }
    
}

extension LoginViewController: ViewModelDelegate {

    func onSuccess() {
        // TODO: Disable loader; Redirect to Home
    }

    func onError(_ error: CustomError) {
        // TODO: Disable loader; Re-enable form
    }

}
