//
//  TabCoordinator.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class HomeTabBarCoordinator: BaseCoordinator, CoordinatorProtocol, TabBarCoordinatorProtocol {

    private lazy var tabViewController = HomeTabBarFactory.build(coordinator: self)

    func start() -> UIViewController {
        addTabs()
        return tabViewController
    }

    private func addTabs() {

        let statsController = ListMoviesFactory.build(coordinator: self)
        let stats = UIImage(systemName: "film")
        statsController.tabBarItem = UITabBarItem(title: Localized.Movies.Trending, image: stats, selectedImage: stats)

        let settingsController = SettingsFactory.build(coordinator: self)
        let gear = UIImage(systemName: "gear")
        settingsController.tabBarItem = UITabBarItem(title: Localized.Settings.SettingsTitle, image: gear, selectedImage: gear)

        let vcs = [
            BaseNavigationController(rootViewController: statsController),
            BaseNavigationController(rootViewController: settingsController)
        ]

        tabViewController.setViewControllers(vcs, animated: false)
        tabViewController.selectedIndex = 0
    }
}

// MARK: Movies coordinator
extension HomeTabBarCoordinator: ListMoviesCoordinatorProtocol {

}
// MARK: Settings coordinator
extension HomeTabBarCoordinator: SettingsCoordinatorProtocol {

}
