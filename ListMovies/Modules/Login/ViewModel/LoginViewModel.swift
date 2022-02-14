//
//  LoginViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func showCreateAccount()
}

class DefaultLoginViewModel: BaseViewModel {
    private let coordinator: LoginCoordinatorProtocol
    private let repository: LoginRepository
    private let credentialsModel: LoginModel = LoginModel()

    // MARK: - Init Methods
    init(coordinator: LoginCoordinatorProtocol, repository: LoginRepository) {
        self.repository = repository
        self.coordinator = coordinator
        super.init()
    }
}
