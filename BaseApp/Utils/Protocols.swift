//
//  Protocols.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: - Typealiases

typealias FormKeyPathDict<T: FormEncodable> = [KeyPath<T, String>: String]

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
            do {
                try UIApplication.shared.open(UIApplication.openSettingsURLString)
            } catch {
                ViewPresenter.presentAlert(.error(error as! CustomError))
            }
        }))

        ViewPresenter.present(alert: alert)
    }

}

// MARK: View Controllers

/// Protocol used for implementing a view controller with an associated form view model.
protocol FormViewModelController {
    
    associatedtype VM where VM: FormViewModel

    var viewModel: VM { get set }
    
}

/// Protocol used for implementing a view controller with an associated view model.
protocol ViewModelController {

    associatedtype VM where VM: ViewModel

    var viewModel: VM { get set }

}

// MARK: View Models

/// Protocol for implementing a view model with form-related functionalities.
protocol FormViewModel {

    associatedtype Params
    associatedtype Response where Response: APIResponseDecodable

    func isFormValid(_ params: Params) -> Bool
    func submitForm(_ params: Params) -> AnyPublisher<Response, Error>

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
