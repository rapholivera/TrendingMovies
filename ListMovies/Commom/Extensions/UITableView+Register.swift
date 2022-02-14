//
//  UITableView+Register.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        let classNameString: String = String(describing: cellClass.self)
        register(cellClass.self, forCellReuseIdentifier: classNameString)
    }
}
