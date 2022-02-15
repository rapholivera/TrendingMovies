//
//  ListMoviesFactory.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class ListMoviesFactory {
    // MARK: - Life Cycle
    class func build(coordinator: ListMoviesCoordinatorProtocol) -> ListMoviesViewController {
        let useCase = DefaultTrendingMoviesUseCase(repository: DefaultMoviesRepository())
        let viewModel = DefaultListMoviesViewModel(coordinator: coordinator, useCase: useCase)
        return ListMoviesViewController(viewModel: viewModel)
    }
}
