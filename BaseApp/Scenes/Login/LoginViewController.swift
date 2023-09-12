//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

final class LoginViewController: UIViewController, ViewModelController {

    typealias ViewModel = LoginViewModel

    var viewModel: LoginViewModel = LoginViewModel() {
        didSet {
            viewModel.delegate = self
        }
    }

    @IBAction private func onLoginClick(_ sender: Any) {
        viewModel.submitForm(.testParams)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension LoginViewController: ViewModelDelegate {

    func onSuccess() {
        performSegue(withIdentifier: R.segue.loginViewController.home,
                     sender: nil)
    }

    func onError(_ error: CustomError) {
        // TODO: Re-enable form
    }

}
