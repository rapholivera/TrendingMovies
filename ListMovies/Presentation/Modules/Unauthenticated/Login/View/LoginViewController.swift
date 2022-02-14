//
//  LoginViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

protocol LoginViewModel: BaseViewModelProtocol {
    var credentials: LoginModel { get }
    var isInputValid: AnyPublisher<Bool, Never> { get }
    func doLogin()
    func doRegister()
}

class LoginViewController: BaseViewController<LoginView> {

    // MARK: - Properties

    private var viewModel: LoginViewModel {
        return baseViewModel as! LoginViewModel
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.authButton.addTarget(self, action: #selector(clickSignin), for: .touchUpInside)
    }

    override func bind() {
        super.bind()

        customView.documentTextField.textPublisher
        .receive(on: DispatchQueue.main)
        .assign(to: \.credentials.document, on: viewModel)
        .store(in: &subscriptions)

        customView.passwordTextField.textPublisher
        .receive(on: DispatchQueue.main)
        .assign(to: \.credentials.password, on: viewModel)
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
