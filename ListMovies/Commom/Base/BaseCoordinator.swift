//
//  BaseCoordinator.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol BaseCoordinatorCallbackProtocol: AnyObject {
    func shouldDismissCoordinator()
    func shouldDismissCoordinatorWith(message: String)
}

protocol CoordinatorProtocol: AnyObject {
    func start() -> UIViewController
    func start(navigationController: BaseNavigationController)
}

extension CoordinatorProtocol {

    func start(navigationController: BaseNavigationController) {
        fatalError("The coordinator needs implement this method")
    }
}

class BaseCoordinator: NSObject {

    weak var callback: BaseCoordinatorCallbackProtocol?

    var childCoordinator: CoordinatorProtocol?
    var actionSheetViewController: UIViewController?

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }

    internal func dismissActionSheetIfNeeded(action: @escaping (() -> Void)) {
        if let actionSheetViewController = actionSheetViewController {
            actionSheetViewController.dismiss(animated: true) {[unowned self] in
                self.actionSheetViewController = nil
                self.childCoordinator = nil
                action()
            }
        } else {
            action()
        }
    }

    func shouldDismissCoordinatorWith(message: String) {
        fatalError("this coordinator should be BaseNavigableCoordinator")
    }

    func dismissActionSheetWith(message: String) {
        fatalError("this coordinator should be BaseNavigableCoordinator")
    }
}

extension BaseCoordinator: BaseCoordinatorCallbackProtocol {

    func shouldDismissCoordinator() {
        self.childCoordinator = nil
        self.dismissActionSheet()
    }
}

extension BaseCoordinator: ActionSheetRouterProtocol {

    func dismissActionSheet() {
        dismissActionSheetIfNeeded {
            // Do nothing
        }
    }
}

class BaseNavigableCoordinator: BaseCoordinator {

    internal var navigationController = BaseNavigationController()

    init(callback: BaseCoordinatorCallbackProtocol?) {
        super.init()
        self.callback = callback
        // navigationController.modalPresentationStyle = .fullScreen
    }

    internal func showActionSheetWith(viewController: UIViewController) {
        let actionSheetViewController = ActionSheetViewController.create(router: self, viewController: viewController)
        self.navigationController.present(actionSheetViewController, animated: true)
        self.actionSheetViewController = actionSheetViewController
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }

    func popWith(message: String) {
        navigationController.popViewController(animated: true)
        if let controller = navigationController.viewControllers.last as? BaseViewController {
            controller.showAlert(text: message)
        }
    }

    func dismiss() {
        navigationController.dismiss(animated: true) {
            self.callback?.shouldDismissCoordinator()
        }
    }

    func dismissWith(message: String) {
        navigationController.dismiss(animated: true) {
            self.callback?.shouldDismissCoordinatorWith(message: message)
        }
    }

    func dismiss(action: @escaping (() -> Void)) {
        navigationController.dismiss(animated: true) {
            self.callback?.shouldDismissCoordinator()
            action()
        }
    }

    override func shouldDismissCoordinatorWith(message: String) {
        childCoordinator = nil

        if let controller = navigationController.viewControllers.last as? BaseViewController {
            controller.showAlert(text: message)
        }
    }

    override func dismissActionSheetWith(message: String) {
        dismissActionSheetIfNeeded {[unowned self] in
            self.shouldDismissCoordinatorWith(message: message)
        }
    }
}
