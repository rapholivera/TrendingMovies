//
//  SettingsCoordinator.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class SettingsCoordinator: BaseNavigableCoordinator, CoordinatorProtocol {

    func start() -> UIViewController {
        showSettingsController()
        return navigationController
    }
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {

    public func showSettingsController() { }
}
