//
//  ListMoviesView.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class ListMoviesView: UIView {

    // MARK: - UI Elements

    internal let moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: - Lyfe Cicle

    init() {
        super.init(frame: CGRect.zero)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension ListMoviesView {

    // MARK: - Layout

    func setupLayout() {

        addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: topAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
