//
//  HomeViewModel.swift
//  BaseApp
//
//  Created by Jason Jon Carreos on 17/9/2023.
//  Copyright © 2023 BTCalls. All rights reserved.
//

import UIKit
import Combine

final class HomeViewModel: ViewModel {
    
    typealias Value = [MarvelCharacter]
    
    @Published var data: [MarvelCharacter] = []
    @Published var error: CustomError?
    @Published var isFetching: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        isFetching = true
        
        APIClient.shared.send(GetCharactersRequest())
            .map { $0.data.results }
            .sink { [weak self] completion in
                self?.isFetching = false
                
                switch completion {
                case .failure(let e):
                    self?.error = e as? CustomError
                    
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.data = response
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        fetchData()
    }
    
}
