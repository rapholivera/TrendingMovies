//
//  AppCoordinator.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    private let window: UIWindow
    private var currentPage: ContentPageType?

    private lazy var containerViewController: ContainerViewController = {
        return ContainerFactory.build(coordinator: self)
    }()

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    func start() {
        window.rootViewController = containerViewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: ContainerCoordinatorProtocol {
    func updateCurrentPage(_ page: ContentPageType) {
        guard page != currentPage else { return }

        switch page {

        case .unauthenticated:
            let signinCoordinatior = LoginCoordinator(callback: nil)
            containerViewController.setCurrentViewController(viewController: signinCoordinatior.start())
            childCoordinator = signinCoordinatior

        case .buildProfile:
            print("buildProfile")
//            let welcomeCoordinator = WelcomeCoordinator(callback: nil)
//            containerViewController.setCurrentViewController(viewController: welcomeCoordinator.start())
//            childCoordinator = welcomeCoordinator

        case .home:
            print("HOME")
            // let chatCoordinator = TabCoordinator()
            // containerViewController.setCurrentViewController(viewController: chatCoordinator.start())
            // childCoordinator = chatCoordinator

        }

        self.currentPage = page
    }

}
