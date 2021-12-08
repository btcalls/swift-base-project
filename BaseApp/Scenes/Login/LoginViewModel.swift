//
//  LoginViewModel.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit

class LoginViewModel: FormViewModel {

    typealias FormParams = LoginRequest

    var delegate: ViewModelDelegate?

    func isFormValid(_ params: LoginRequest) -> FormViewModelResponse {
        if params.userName.isEmpty {
            return .error(message: "Username is required.")
        }

        if params.password.isEmpty {
            return .error(message: "Password is required.")
        }

        return .success
    }

    func submitForm(_ params: LoginRequest) {
        let status = isFormValid(params)

        switch status {
        case .success:
            login(with: params)

        case .error(let message):
            ViewPresenter.presentAlert(.custom(title: "", message: message))
        }
    }

    private func login(with params: LoginRequest) {
        AppDelegate.shared.showLoader()
        APIClient.shared.request(
            to: .login,
            method: .post(params),
            responseType: LoginResponse.self
        ) { [weak self] result in
            switch result {
            case .success(_):
                // TODO: Store tokens, etc.
                self?.delegate?.onSuccess()

            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }

}
