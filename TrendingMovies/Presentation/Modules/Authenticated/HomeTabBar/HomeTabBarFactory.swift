//
//  TabBarFactory.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class HomeTabBarFactory {
    // MARK: - Life Cycle
    class func build(coordinator: TabBarCoordinatorProtocol) -> HomeTabBarViewController {
        let viewModel = DefaultTabBarViewModel(coordinator: coordinator)
        return HomeTabBarViewController(viewModel: viewModel)
    }
}
