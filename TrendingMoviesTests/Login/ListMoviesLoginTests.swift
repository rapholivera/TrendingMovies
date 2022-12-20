//
//  ListMoviesLoginTests.swift
//  ListMoviesTests
//
//  Created by Raphael Oliveira on 2/14/22.
//

import XCTest
import Combine

@testable import TrendingMovies

class ListMoviesLoginTests: XCTestCase {

    /// `RN 1.` Signing button should be enabled only if booth `Document` and `Password` fields are filled
    func test_validInput() {

        // given
        let loginViewModel = createMockLoginViewModel()

        let spy = ValueSpy(loginViewModel.isInputValid)

        // then
        XCTAssertEqual(spy.values, [false])

        // when
        loginViewModel.credentials.document = "email@google.com"

        // then
        XCTAssertEqual(spy.values, [false, false])

        // when
        loginViewModel.credentials.password = "password123"

        // then
        XCTAssertEqual(spy.values, [false, false, true])
    }

    /// `RN 2.` When user successfully login change session state to `hasSession`
    func test_userAuthentication_Success() {

        /// We should do the same with `RN 3.`
        let mockSession = MockSessionManager(state: .notHaveSession)

        let sut: LoginViewController = createInvalidLoginMockSession(session: mockSession)

        let spy = ValueSessionSpy(mockSession.sessionState.eraseToAnyPublisher())

        // then
        XCTAssertEqual(spy.values, [.notHaveSession])

        // when
        sut.customView.authButton.sendActions(for: .touchUpInside)

        // then
        XCTAssertEqual(spy.values, [.notHaveSession, .hasSession])

    }

    /// `RN 3.` When user type wrong credential an alert shoud pop in
    func test_userAuthentication_Error() {

        /// We should do the same with `RN 3.`
        let mockSession = MockSessionManager(state: .notHaveSession)

        let sut: LoginViewController = createInvalidLoginMockSession(session: mockSession)

        let spy = ValueSessionSpy(mockSession.sessionState.eraseToAnyPublisher())

        // then
        XCTAssertEqual(spy.values, [.notHaveSession])

        // when
        sut.customView.authButton.sendActions(for: .touchUpInside)

        // then
        XCTAssertEqual(spy.values, [.notHaveSession, .hasSession])
    }

}

private func createLoginMockSession(session: SessionManagerProtocol) -> LoginViewController {
    let user: UserDTO = createValidMockUserResponse()
    let repository: LoginRepository = LoginRepositorySpy(result: user)
    let coordinator = LoginCoordinatorDummy()
    let viewModel = MockLoginViewModel(coordinator: coordinator, repository: repository, session: session)
    return LoginViewController(viewModel: viewModel)
}

private func createInvalidLoginMockSession(session: SessionManagerProtocol) -> LoginViewController {
    let user: UserDTO = createInvalidMockUserResponse()
    let repository: LoginRepository = LoginRepositorySpy(result: user)
    let coordinator = LoginCoordinatorDummy()
    let viewModel = MockLoginViewModel(coordinator: coordinator, repository: repository, session: session)
    return LoginViewController(viewModel: viewModel)
}

private func createLoginInvalidSession() -> LoginViewController {
    let error: APIError = .badCredentials
    let repository: LoginRepository = LoginRepositorySpy(result: error)
    return createMockLoginController(repository: repository)
}

private func createMockLoginController(repository: LoginRepository) -> LoginViewController {
    let coordinator = LoginCoordinatorDummy()
    let viewModel = LoginViewModel(coordinator: coordinator, repository: repository)

    viewModel.credentials.document = "email@google.com"

    // then
    // XCTAssertEqual(spy.values, [false, false])

    // when
    viewModel.credentials.password = "password123"
    return LoginViewController(viewModel: viewModel)
}

private func createValidMockUserResponse() -> UserDTO {
    let randomAccessToken: String = UUID().uuidString
    return UserDTO(name: "User", code: randomAccessToken, mail: "movies@movies.com")
}

private func createInvalidMockUserResponse() -> UserDTO {
    return UserDTO(name: "User", code: "", mail: "movies@movies.com")
}

/// Create a mock login view model to use in tests
private func createMockLoginViewModel() -> LoginViewModelProtocol {

    let coordinator: LoginCoordinatorProtocol = LoginCoordinatorDummy()

    let repository: LoginRepository = LoginRepositorySpy(result: createValidMockUserResponse())

    return LoginViewModel(coordinator: coordinator, repository: repository)
}

private class LoginCoordinatorDummy: LoginCoordinatorProtocol {
    func showCreateAccount() {
        // TODO: test navigation
    }
}

// MARK: - Login Repository Layer
private class LoginRepositorySpy: LoginRepository {

    private let result: Result<UserDTO, APIError>

    init(result: UserDTO) {
        self.result = .success(result)
    }
    init(result: APIError) {
        self.result = .failure(result)
    }

    func auth(credentials: LoginModel, completion: @escaping (Result<UserDTO, APIError>) -> Void) {
        // TODO: test response
        completion(result)
    }
}

private class ValueSpy {
    private(set) var values = [Bool]()
    private var cancellable: AnyCancellable?

    init(_ publisher: AnyPublisher<Bool, Never>) {
        cancellable = publisher.sink(receiveValue: { [weak self] value in
            self?.values.append(value)
        })
    }
}

private class ValueSessionSpy {
    private(set) var values = [UserSessionState]()
    private var cancellable: AnyCancellable?

    init(_ publisher: AnyPublisher<UserSessionState, Error>) {
        cancellable = publisher.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
            self?.values.append(value)
        })
    }
}
