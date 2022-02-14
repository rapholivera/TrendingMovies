//
//  ListMoviesViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol ListMoviesViewModel {
    func loadMovies()
}

class ListMoviesViewController: BaseViewController<ListMoviesView> {

    // MARK: - Properties

    private var viewModel: ListMoviesViewModel {
        return baseViewModel as! ListMoviesViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        customView.moviesTableView.dataSource = self
        customView.moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        customView.moviesTableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadMovies()
    }
}

extension ListMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as? MovieTableViewCell else {
            return UITableViewCell()
        }

        cell.movieNameLabel.text = "teste"

        return cell
    }
}
