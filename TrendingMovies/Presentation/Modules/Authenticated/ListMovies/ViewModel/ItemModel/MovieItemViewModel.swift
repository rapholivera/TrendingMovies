//
//  MovieItemViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

struct MovieItemViewModel: TableViewCellModelProtocol {
    let cellIdentifier: String = "MovieTableViewCell"
    let movie: MovieDTO
}
