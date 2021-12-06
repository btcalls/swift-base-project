//
//  SLProtocols.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 Slomins. All rights reserved.
//

import Foundation
import UIKit

enum SLFormViewModelResponse {
    case success
    case error(message: String)
}

protocol SLViewModel {

    func fetchData()
    func reloadData()

}

protocol SLFormViewController {

    associatedtype ViewModel

    var viewModel: ViewModel { get set }

}

protocol SLFormViewModelDelegate {

    func onSuccess()
    func onError(_ error: SLError)

}

protocol SLFormViewModel {

    associatedtype FormParams

    var delegate: SLFormViewModelDelegate? { get set }

    func isFormValid(_ params: FormParams) -> SLFormViewModelResponse
    func submitForm(_ params: FormParams)

}
