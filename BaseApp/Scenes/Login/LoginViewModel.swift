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
            login()

        case .error(let message):
            AppDelegate.shared.presentDialog(type: .custom(title: "Validation",
                                                           message: message))
        }
    }

    private func login() {
        APIClient.shared.post(type: LoginResponse.self,
                                endpoint: .login,
                                body: LoginRequest.testParams) { [weak self] result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.appSid, forKey: .appSid)
                self?.delegate?.onSuccess()

            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }

}
