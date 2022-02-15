//
//  HomeTabBarViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol TabBarCoordinatorProtocol { }

class DefaultTabBarViewModel: BaseViewModel {

    // MARK: - Properties

    private let coordinator: TabBarCoordinatorProtocol

    // MARK: - Init Methods
    init(coordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init()
    }
}

extension DefaultTabBarViewModel: HomeTabBarViewModel {

}
