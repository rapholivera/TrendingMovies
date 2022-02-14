//
//  DefaultMoviesRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class DefaultMoviesRepository: MoviesRepository {

    private var engine: NetworkEngineRouter<MoviesService> {
        return NetworkEngineRouter<MoviesService>()
    }

    func getTrendingMovies(completion: @escaping (Result<[MovieApi], APIError>) -> Void) {
        engine.request(target: .getTrendingMovies, completion: completion)
    }
}
