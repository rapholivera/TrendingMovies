//
//  LoginFactory.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class LoginFactory {
    // MARK: - Life Cycle
    class func build(coordinator: LoginCoordinatorProtocol) -> LoginViewController {
        let repository = DefaultLoginRepository()
        let viewModel = LoginViewModel(coordinator: coordinator, repository: repository)
        return LoginViewController(viewModel: viewModel)
    }
}
