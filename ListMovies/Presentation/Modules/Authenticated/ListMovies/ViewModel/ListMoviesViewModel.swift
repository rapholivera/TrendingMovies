//
//  ListMoviesViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol ListMoviesCoordinatorProtocol {

}

class DefaultListMoviesViewModel: BaseViewModel {
    private let coordinator: ListMoviesCoordinatorProtocol
    private let useCase: TrendingMoviesUseCase

    // MARK: - Init Methods
    init(coordinator: ListMoviesCoordinatorProtocol, useCase: TrendingMoviesUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
        super.init()
    }
}

extension DefaultListMoviesViewModel: ListMoviesViewModel {
    func loadMovies() {

    }
}
