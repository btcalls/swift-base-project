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

/// Typealias for a dictionary in which its key is derived from properties of another encodable object.
///
/// Used for declaring dictionary of errors corresponding to the encodable properties.
typealias FormKeyPathDict<T: FormEncodable> = [KeyPath<T, String>: String]

// MARK: Cells

/// Protocol to be conformed by UITableViewCell instances in which contents are derived from objects.
protocol ConfigurableCell {

    associatedtype T

    func configure(with value: T)

}

// MARK: Managers

/// Protocol to be implemented by manager instances corresponding to a capability (e.g. Push Notifications, Location).
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
                ViewPresenter.presentAlert(.error(CustomError.error(error)))
            }
        }))

        ViewPresenter.present(alert: alert)
    }

}

// MARK: - API

/// Protocol for decodable instances used to encapsulate an API response.
protocol APIResponseDecodable: Decodable {

    // TODO: Add common response data properties

}

/// Protocol for decodable instances used to encapsulate an API response returning a list of data.
protocol APIListResponseDecodable: APIResponseDecodable {

    associatedtype Item where Item: Decodable
    
    var copyright: String { get } // NOTE: Marvel API-specific. Remove after.
    var data: DataContainer<Item> { get }

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

    /// Published property for data fetched by view model. Add @Published wrapper upon implementation.
    var data: Value { get set }
    /// Published property for error received by view model. Add @Published wrapper upon implementation.
    var error: CustomError? { get }
    /// Published property for fetching state managed by view model. Add @Published wrapper upon implementation.
    var isFetching: Bool { get set }

    func fetchData()
    func reloadData()

}
