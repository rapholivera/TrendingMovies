//
//  TableViewCellProtocol.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol TableViewCellProtocol {
    func bind(with data: TableViewCellModelProtocol)
}

protocol TableViewCellModelProtocol {
    var cellIdentifier: String { get }
}
