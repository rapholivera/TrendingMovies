//
//  TrendingMoviesUseCase.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol TrendingMoviesUseCase {
    /// Get Trending movies
    func loadTrendingMovies(completion: @escaping (Result<[TableViewCellModelProtocol], APIError>) -> Void)
}

class DefaultTrendingMoviesUseCase: TrendingMoviesUseCase {
    let repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func loadTrendingMovies(completion: @escaping (Result<[TableViewCellModelProtocol], APIError>) -> Void) {
        repository.getTrendingMovies { response in
            switch response {
            case .success(let movies):
                let itemModels = movies.results.map({ MovieItemViewModel(movie: $0) })
                completion(.success(itemModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
