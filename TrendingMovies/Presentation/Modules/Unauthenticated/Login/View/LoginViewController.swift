//
//  LoginViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    // MARK: - Properties
    let customView = LoginView()
    private let viewModel: LoginViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.authButton.addTarget(self, action: #selector(clickSignin), for: .touchUpInside)
        bind()
    }

    private func bind() {

        customView.documentTextField.textPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in self?.viewModel.didUpdateDocumentTextField(document: $0) })
            .store(in: &subscriptions)

        customView.passwordTextField.textPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in self?.viewModel.didUpdatePasswordTextField(password: $0) })
            .store(in: &subscriptions)

        viewModel.isInputValid
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: customView.authButton)
            .store(in: &subscriptions)
    }

    // MARK: - Actions

    @objc private func clickSignin() {
        view.endEditing(true)
        viewModel.doLogin()
    }
}
