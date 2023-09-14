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
    
    typealias Params = LoginBody
    typealias Response = LoginRequest.Response
    
    @Published var formErrors: FormKeyPathDict<LoginBody> = [:]
    
    private var cancellables = Set<AnyCancellable>()

    func isFormValid(_ params: LoginBody) -> Bool {
        var errors: FormKeyPathDict<LoginBody> = [:]
        
        if params.userName.isEmpty {
            errors[\.userName] = "Username is required."
        }

        if params.password.isEmpty {
            errors[\.password] = "Password is required."
        }
        
        formErrors = errors

        return errors.isEmpty
    }

    func submitForm(_ params: LoginBody) -> AnyPublisher<LoginRequest.Response, Error> {
        return APIClient.shared.send(LoginRequest(method: .post(params)))
    }

}
