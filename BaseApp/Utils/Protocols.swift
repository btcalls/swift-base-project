//
//  Protocols.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation
import UIKit

// MARK: Cells

protocol ConfigurableCell {

    associatedtype T

    func configure(with value: T)

}

// MARK: Managers

protocol CapabilityManager {

    /// Flag whether corresponding capability has been authorized for usage.
    var isAuthorized: Bool { get set }

    /// Applies configuration to correponding capability's manager to prepare for authorization request.
    func configure()
    /// Calls the correponding capability's manager's authorization request.
    func requestAuthorization()

}

extension CapabilityManager {

    func presentRequireDialog(_ message: PermissionType) {
        let alert = UIAlertController(title: "Enable Settings",
                                      message: message.rawValue,
                                      preferredStyle: .alert)

        alert.addAction(.init(title: "Close", style: .cancel))
        alert.addAction(.init(title: "Open Settings", style: .default, handler: { _ in
            UIApplication.shared.open(UIApplication.openSettingsURLString)
        }))

        ViewPresenter.present(alert: alert)
    }

}

// MARK: View Controllers

/// Protocol used for implementing a view controller with an associated view model.
protocol ViewModelController {

    associatedtype ViewModel

    var viewModel: ViewModel { get set }

}

// MARK: View Models

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

    associatedtype Value

    var data: Value { get set }
    var delegate: ViewModelDelegate? { get set }

    func fetchData()
    func reloadData()

}

/// Protocol for capturing the state of a view model API request action.
protocol ViewModelDelegate {

    func onSuccess()
    func onError(_ error: CustomError)

}
