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
    typealias LoginCredentials = (document: String, password: String)

    var isInputValid: AnyPublisher<Bool, Never> { get }

    func didUpdateDocumentTextField(document: String)
    func didUpdatePasswordTextField(password: String)
    func doLogin()
    func doRegister()
}

class LoginViewModel: BaseViewModel {
    private let coordinator: LoginCoordinatorProtocol
    private let repository: LoginRepository
    private let session: SessionManagerProtocol
    private let credentialsModel: LoginModel = LoginModel()

    // MARK: - Init Methods
    init(coordinator: LoginCoordinatorProtocol, repository: LoginRepository,
         session: SessionManagerProtocol) {
        self.repository = repository
        self.coordinator = coordinator
        self.session = session
        super.init()
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func didUpdateDocumentTextField(document: String) {
        credentialsModel.document = document
    }

    func didUpdatePasswordTextField(password: String) {
        credentialsModel.password = password
    }

    var isInputValid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(credentialsModel.$document, credentialsModel.$password)
            .map { $0.count > 0 && $1.count > 0 }
            .eraseToAnyPublisher()
    }

    func doLogin() {
        repository.auth(credentials: credentialsModel) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let userAPI):
                do {
                    try self.session.createUserSession(accessToken: userAPI.code,
                                                       currentUser: UserDB.map(userAPI: userAPI))
                } catch {
                    self.session.expireSession()
                }
            case .failure(let error):
                self.alertSubject.send(error.localizedDescription)
            }
        }
    }

    func doRegister() { }
}
