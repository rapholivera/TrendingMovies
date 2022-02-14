//
//  BaseTitleLabel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class BaseTitleLabel: UILabel {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment

        setupUI()
    }

    // MARK: - UI Setup

    fileprivate func setupUI() {
        textColor = .white
        font = .preferredFont(forTextStyle: .title3)
        adjustsFontForContentSizeCategory = true
        lineBreakMode = .byWordWrapping
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
