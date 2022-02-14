//
//  ActionSheetViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class ActionSheetViewController: BaseViewController<BaseView> {

    private var viewModel: ActionSheetViewModelProtocol! {
        return baseViewModel as? ActionSheetViewModelProtocol
    }

    private let presentationManager = ActionSheetPresentationManager()

    let topView = UIView()
    let footerContainerView = UIView()

    override init(viewModel: BaseViewModelProtocol) {
        super.init(viewModel: viewModel)
        modalPresentationStyle = .custom
        transitioningDelegate = presentationManager
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    static func create(router: ActionSheetRouterProtocol,
                       viewController: UIViewController) -> ActionSheetViewController {
        let viewModel = ActionSheetViewModel(footerViewController: viewController, router: router)
        return ActionSheetViewController(viewModel: viewModel)
    }

    override func loadView() {
        super.loadView()
        addBottomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackWith(alpha: 0.5)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
        view.addGestureRecognizer(tap)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor/*, constant: -self.keyboardRect.size.height*/),
            footerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }

    // MARK: - Selectors

    @objc func tapBackground(_ sender: UITapGestureRecognizer? = nil) {
        viewModel.didTapOutsideBottomView()
    }
}

extension ActionSheetViewController {

    private func addBottomView() {
        view.addSubview(topView)
        view.addSubview(footerContainerView)

        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        addFooterViewController()
    }

    private func addFooterViewController() {
        addChild(viewModel.footerViewController)
        viewModel.footerViewController.view.frame = footerContainerView.frame
        footerContainerView.addSubview(viewModel.footerViewController.view)
        viewModel.footerViewController.didMove(toParent: self)
        viewModel.footerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewModel.footerViewController.view.topAnchor.constraint(equalTo: footerContainerView.safeAreaLayoutGuide.topAnchor),
            viewModel.footerViewController.view.bottomAnchor.constraint(equalTo: footerContainerView.safeAreaLayoutGuide.bottomAnchor),
            viewModel.footerViewController.view.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor),
            viewModel.footerViewController.view.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor)
        ])
    }
}
