//
//  LoginViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit
import Combine

final class LoginViewController: UIViewController, FormViewModelController {

    typealias ViewModel = LoginViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!

    @IBAction private func onLoginClick(_ sender: Any) {
        let params: LoginViewModel.Params = .init(password: "asd",
                                                  userName: "")
        
        guard viewModel.isFormValid(params) else {
            return
        }
        
        AppDelegate.shared.showLoader()
        viewModel.submitForm(params)
            .sink { [weak self] completion in
                AppDelegate.shared.hideLoader {
                    switch completion {
                    case .failure(let error):
                        ViewPresenter.presentAlert(.error(error as! CustomError))
                        
                    case .finished:
                        self?.performSegue(withIdentifier: R.segue.loginViewController.home,
                                           sender: nil)
                    }
                }
            } receiveValue: { response in
                Debugger.print(response)
                UserDefaults.standard.set(response.token, forKey: .accessToken)
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        subscribeToForm()
    }

}

extension LoginViewController {
    
    private func subscribeToForm() {
        viewModel.$formErrors
            .sink { [weak self] errors in
                self?.usernameLabel.text = errors[\.userName]
                self?.passwordLabel.text = errors[\.password]
            }
            .store(in: &cancellables)
    }
    
}
