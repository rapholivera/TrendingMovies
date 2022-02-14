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
            let loginCoordinator = LoginCoordinator(callback: nil)
            containerViewController.setCurrentViewController(viewController: loginCoordinator.start())
            childCoordinator = loginCoordinator
        case .buildProfile:
            // TODO: Create an onboarding workflow
            print("TODO: Create an onboarding workflow")
        case .home:
             let tabBarCoordinator = HomeTabBarCoordinator()
             containerViewController.setCurrentViewController(viewController: tabBarCoordinator.start())
             childCoordinator = tabBarCoordinator

        }

        self.currentPage = page
    }

}
