//
//  BaseViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

class BaseViewController<CustomView: UIView>: UIViewController {

    internal let baseViewModel: BaseViewModelProtocol
    internal var subscriptions = Set<AnyCancellable>()
    private var placeholderView: UIView?

    init(viewModel: BaseViewModelProtocol) {
        baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    convenience required init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    var customView: CustomView! {
        return self.view as? CustomView
    }

    override func loadView() {
        self.view = CustomView()
        view.backgroundColor = .backgroundPrimaryColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftItemsSupplementBackButton = true
        removeBackButtonTitle()
        bind()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }

    internal func bind() {

        baseViewModel.viewState.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (state) in
            switch state {
            case .normal:
                self?.removePlaceholder()
            case .failure(let viewModel):
                self?.showError(viewModel: viewModel)
            case .loadingNormal:
                self?.showLoading(text: nil)
            case .loadingWith(let text):
                self?.showLoading(text: text)
            }
        }).store(in: &subscriptions)

        baseViewModel.alert.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (text) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(text: text)
            }
        }).store(in: &subscriptions)
    }
}

extension BaseViewController {

    private func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension BaseViewController {

    private func removePlaceholder() {
        placeholderView?.removeFromSuperview()
    }

    private func showLoading(text: String?) {
        self.view.endEditing(true)
        removePlaceholder()

        let loadingView = LoadingView()
        let view: UIView = navigationController?.view ?? self.view
        loadingView.presentOn(parentView: view, with: text)
        self.placeholderView = loadingView
    }

    private func showError(viewModel: PlaceholderViewModel) {
        self.view.endEditing(true)
        removePlaceholder()

        let errorView = ErrorView()
        let view: UIView = navigationController?.view ?? self.view
        errorView.presentOn(parentView: view, with: viewModel)
        self.placeholderView = errorView
    }
}

extension BaseViewController {

    func showAlert(text: String) {

        let dialogMessage = UIAlertController(title: "Ops!", message: text, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
            print("Ok button tapped")
        }))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
