//
//  LoginViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

protocol LoginCoordinatorProtocol {
    func showCreateAccount()
}

protocol LoginViewModelProtocol: BaseViewModelProtocol {
    var credentials: LoginModel { get }
    var isInputValid: AnyPublisher<Bool, Never> { get }
    func doLogin()
    func doRegister()
}

class LoginViewModel: BaseViewModel {
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

extension LoginViewModel: LoginViewModelProtocol {
    var credentials: LoginModel {
        return credentialsModel
    }

    var isInputValid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(credentials.$document, credentials.$password)
            .map { $0.count > 0 && $1.count > 0 }
            .eraseToAnyPublisher()
    }

    func doLogin() {
        repository.auth(credentials: credentials) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let userAPI):
                do {
                    try SessionManager.shared.createUserSession(accessToken: userAPI.code, currentUser: UserDB.map(userAPI: userAPI))
                } catch {
                    SessionManager.shared.expireSession()
                }
            case .failure(let error):
                self.alertSubject.send(error.localizedDescription)
            }
        }
    }

    func doRegister() { }
}
