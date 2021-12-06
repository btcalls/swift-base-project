//
//  SLLoginViewController.swift
//  ChatApp
//
//  Created by Jason Jon E. Carreos on 12/3/21.
//

import UIKit

class SLLoginViewController: UIViewController, SLFormViewController {

    typealias ViewModel = SLLoginViewModel

    var viewModel: SLLoginViewModel = SLLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.viewModel.delegate = self

        if SLAPIClient.shared.isAuthenticated {
            // TODO: Redirect to Home
        }
    }
    
}

extension SLLoginViewController: SLFormViewModelDelegate {

    func onSuccess() {
        // TODO: Disable loader; Redirect to Home
    }

    func onError(_ error: SLError) {
        // TODO: Disable loader; Re-enable form
    }

}
