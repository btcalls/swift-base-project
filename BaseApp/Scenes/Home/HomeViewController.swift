//
//  HomeViewController.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/6/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit
import Combine

final class HomeViewController: UIViewController, ViewModelController {
    
    typealias VM = HomeViewModel
    
    var viewModel: HomeViewModel = .init()
    
    private var cancellables = Set<AnyCancellable>()

    @IBAction private func onLogoutClick(_ sender: Any) {
        AppDelegate.shared.logout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.fetchData()
        subscribeToViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.$isFetching
            .sink { isFetching in
                if isFetching {
                    AppDelegate.shared.showLoader()
                }
            }
            .store(in: &cancellables)
    }

}

extension HomeViewController {
    
    private func subscribeToViewModel() {
        viewModel.$data
            .sink { characters in
                AppDelegate.shared.hideLoader {
                    // TODO: Datasource
                    Debugger.print(characters.map { $0.name })
                }
            }
            .store(in: &cancellables)
        viewModel.$error
            .sink { error in
                AppDelegate.shared.hideLoader {
                    if let error = error {
                        ViewPresenter.presentAlert(.error(error))
                    }
                }
            }
            .store(in: &cancellables)
    }
    
}
