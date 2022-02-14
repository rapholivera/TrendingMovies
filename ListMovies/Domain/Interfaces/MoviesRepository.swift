//
//  MoviesRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol MoviesRepository {
    func getTrendingMovies(completion: @escaping (Result<[MovieApi], APIError>) -> Void)
}
