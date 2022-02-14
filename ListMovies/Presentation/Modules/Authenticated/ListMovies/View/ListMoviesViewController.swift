//
//  ListMoviesViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit
import Combine

protocol ListMoviesViewModel {
    /// Called to reload  tableview after service response
    var reloadMoviesTableViewObservable: AnyPublisher<Void, Never> { get }
    /// Return number of rows in tableview datasource
    var numberOfItems: Int { get }
    /// Return model protocol to fill cell content
    func getCellModel(at index: Int) -> TableViewCellModelProtocol
    /// Fetch trending movies
    func loadMovies()
}

class ListMoviesViewController: BaseViewController<ListMoviesView> {

    // MARK: - Properties

    private var viewModel: ListMoviesViewModel {
        return baseViewModel as! ListMoviesViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Movies"
        customView.moviesTableView.dataSource = self
        customView.moviesTableView.delegate = self
        customView.moviesTableView.register(cellClass: MovieTableViewCell.self)

        viewModel.loadMovies()
    }

    override func bind() {
        super.bind()

        viewModel.reloadMoviesTableViewObservable.sink(receiveValue: { [weak self] (_) in
            DispatchQueue.main.async { [weak self] in
                self?.customView.moviesTableView.reloadData()
            }
        }).store(in: &subscriptions)
    }
}

extension ListMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getCellModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier) as? TableViewCellProtocol
        cell?.bind(with: cellModel)
        return cell as? UITableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
