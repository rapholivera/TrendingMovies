//
//  ContainerViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

protocol ContainerViewModelProtocol: BaseViewModelProtocol {
    var applicationStateDidChange: CurrentValueSubject<ApplicationState, Error> { get }
    func updateCurrentPage(page: ContentPageType)
}

class ContainerViewController: BaseViewController<BaseView> {

    private var viewModel: ContainerViewModelProtocol! {
        return baseViewModel as? ContainerViewModelProtocol
    }

    private(set) var currentViewController: UIViewController? {
        didSet {
            if let currentViewController = currentViewController {
                currentViewController.willMove(toParent: self)
                addChild(currentViewController)
                currentViewController.didMove(toParent: self)

                if let oldViewController = oldValue {
                    view.insertSubview(currentViewController.view, belowSubview: oldViewController.view)
                } else {
                    view.addSubview(currentViewController.view)
                }

                currentViewController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    currentViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    currentViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    currentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    currentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])

                self.setNeedsStatusBarAppearanceUpdate()
            }

            if let oldViewController = oldValue {
                self.applyScreenTransition(newViewController: currentViewController, oldViewController: oldViewController)
                PresentationHelper.romePresentedModalsViewControllers()
            }
        }
    }

    class func create(coordinator: ContainerCoordinatorProtocol) -> ContainerViewController {
        let viewModel = ContainerViewModel(coordinator: coordinator, repository: DefaultContainerRepository())
        return ContainerViewController(viewModel: viewModel)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let currentViewController = currentViewController else {
            return .lightContent
        }

        return currentViewController.preferredStatusBarStyle
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .backgroundPrimaryColor
    }

    override func bind() {
        super.bind()

        viewModel.applicationStateDidChange.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (appState) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch appState {
                case .logged(let hasProfile):
                    self.viewModel.updateCurrentPage(page: hasProfile ? .home : .buildProfile)
                case .expired, .notLogged:
                    self.viewModel.updateCurrentPage(page: .unauthenticated)
                }
            }
        }).store(in: &subscriptions)
    }

    private func applyScreenTransition(newViewController: UIViewController?, oldViewController: UIViewController) {
        if let newViewController = newViewController {
            newViewController.view.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.size.height))

            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [], animations: {
                newViewController.view.transform = CGAffineTransform.identity
                oldViewController.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)

            }, completion: { (_) in
                oldViewController.removeDefinitely()
            })

        } else {
            oldViewController.removeDefinitely()
        }
    }
}

extension ContainerViewController {

    func setCurrentViewController(viewController: UIViewController) {
        currentViewController = viewController
    }
}
