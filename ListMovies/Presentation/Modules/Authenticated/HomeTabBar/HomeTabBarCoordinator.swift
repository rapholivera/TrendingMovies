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

        let statsController = UIViewController()// BaseNavigationController(rootViewController: UserListsViewController.create(coordinator: self))
        let stats = UIImage(systemName: "house")
        let statsCalls = UIImage(systemName: "house")
        statsController.tabBarItem = UITabBarItem(title: "Feed", image: stats, selectedImage: statsCalls)

        let settingsController = SettingsFactory.build(coordinator: self)
        let gear = UIImage(systemName: "gear")
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: gear, selectedImage: gear)

        let vcs = [
            statsController,
            settingsController
        ]

        tabViewController.setViewControllers(vcs, animated: false)
        tabViewController.selectedIndex = 0
    }
}

extension HomeTabBarCoordinator: SettingsCoordinatorProtocol {

}
