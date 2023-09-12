//
//  LoginViewModel.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit
import Combine

final class LoginViewModel: FormViewModel {

    typealias FormParams = LoginBody

    var delegate: ViewModelDelegate?
    
    private var cancellable = Set<AnyCancellable>()

    func isFormValid(_ params: LoginBody) -> FormViewModelResponse {
        if params.userName.isEmpty {
            return .error(message: "Username is required.")
        }

        if params.password.isEmpty {
            return .error(message: "Password is required.")
        }

        return .success
    }

    func submitForm(_ params: LoginBody) {
        let status = isFormValid(params)

        switch status {
        case .success:
            login(with: params)

        case .error(let message):
            ViewPresenter.presentAlert(.custom(title: "", message: message))
        }
    }

    private func login(with params: LoginBody) {
        AppDelegate.shared.showLoader()
        APIClient.shared.send(LoginRequest(method: .post(params)))
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.delegate?.onSuccess()

                case .failure(_):
                    self?.delegate?.onError(.custom("Error"))
                }
            } receiveValue: { response in
                Debugger.print(response)
            }
            .store(in: &cancellable)

    }

}
