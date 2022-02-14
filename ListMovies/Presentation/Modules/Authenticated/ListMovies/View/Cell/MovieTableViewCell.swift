//
//  MovieTableViewCell.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    internal let movieNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
}

extension MovieTableViewCell {

    // MARK: - Layout

    func setupViews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(movieNameLabel)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            movieNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
