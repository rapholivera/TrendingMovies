//
//  LoginCoordinator.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class LoginCoordinator: BaseNavigableCoordinator, CoordinatorProtocol {

    func start() -> UIViewController {
        showUnauthenticated()
        return navigationController
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {

    public func showUnauthenticated() {
        navigationController.setViewControllers([LoginFactory.build(coordinator: self)], animated: true)
    }
    func showCreateAccount() {/* TODO */}
}
