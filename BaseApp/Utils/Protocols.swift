//
//  Protocols.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation
import UIKit

/// Protocol used for implementing a view controller with an associated view model.
protocol ViewModelController {

    associatedtype ViewModel

    var viewModel: ViewModel { get set }

}

// MARK: View Model

enum FormViewModelResponse {
    case success
    case error(message: String)
}

/// Protocol for implementing a view model with form-related functionalities.
protocol FormViewModel {

    associatedtype FormParams

    var delegate: ViewModelDelegate? { get set }

    func isFormValid(_ params: FormParams) -> FormViewModelResponse
    func submitForm(_ params: FormParams)

}

/// Protocol for implementing a view model with fetching/reloading data capabilities used for populating a screen.
protocol ViewModel {

    var delegate: ViewModelDelegate? { get set }

    func fetchData()
    func reloadData()

}

/// Protocol for capturing the state of a view model API request action.
protocol ViewModelDelegate {

    func onSuccess()
    func onError(_ error: CustomError)

}
