//
//  ListMoviesViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit
import Combine

protocol ListMoviesCoordinatorProtocol {

}

class DefaultListMoviesViewModel: BaseViewModel {
    private let coordinator: ListMoviesCoordinatorProtocol
    private let useCase: TrendingMoviesUseCase
    private var tableViewCellModels: [TableViewCellModelProtocol] = []
    private let reloadMoviesSubject = PassthroughSubject<Void, Never>()

    // MARK: - Init Methods
    init(coordinator: ListMoviesCoordinatorProtocol, useCase: TrendingMoviesUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
        super.init()
    }
}

extension DefaultListMoviesViewModel: ListMoviesViewModel {
    /// Called to reload  tableview after service response
    var reloadMoviesTableViewObservable: AnyPublisher<Void, Never> {
        return reloadMoviesSubject.eraseToAnyPublisher()
    }
    /// Return number of rows in tableview datasource
    var numberOfItems: Int {
        return tableViewCellModels.count
    }
    /// Return model protocol to fill cell content
    func getCellModel(at index: Int) -> TableViewCellModelProtocol {
        return tableViewCellModels[index]
    }
    /// Fetch trending movies
    func loadMovies() {

        newViewStateSubject.onLoading(text: Localized.Movies.LoadingMovies)

        useCase.loadTrendingMovies { [weak self] response in

            DispatchQueue.main.async { [weak self] in
                self?.newViewStateSubject.onNormal()
            }

            switch response {
            case .success(let movieModels):
                self?.tableViewCellModels = movieModels
                self?.reloadMoviesSubject.send()
            case .failure(let error):
                // TODO: - throw error message
                print("error:\(String(describing: error.errorDescription))")
            }
        }
    }
}
