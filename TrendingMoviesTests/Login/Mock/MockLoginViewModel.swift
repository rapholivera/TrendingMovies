//
//  MockLoginViewModel.swift
//  TrendingMoviesTests
//
//  Created by Raphael Oliveira on 12/04/22.
//

import UIKit
import Combine
@testable import TrendingMovies

class MockLoginViewModel: BaseViewModel {

    private let coordinator: LoginCoordinatorProtocol
    private let repository: LoginRepository
    private let session: SessionManagerProtocol
    private let credentialsModel: LoginModel = LoginModel()

    // MARK: - Init Methods
    init(coordinator: LoginCoordinatorProtocol, repository: LoginRepository, session: SessionManagerProtocol) {
        self.repository = repository
        self.coordinator = coordinator
        self.session = session
        super.init()
    }

}

extension MockLoginViewModel: LoginViewModel {
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
                    try self.session.createUserSession(accessToken: userAPI.code, currentUser: UserDB.map(userAPI: userAPI))
                } catch {
                    self.session.expireSession()
                }
            case .failure(let error):
                self.alertSubject.send(error.localizedDescription)
            }
        }
    }

    func doRegister() {

    }
}
