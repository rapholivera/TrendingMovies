//
//  ListMoviesLoginTests.swift
//  ListMoviesTests
//
//  Created by Raphael Oliveira on 2/14/22.
//

import XCTest
import Combine

@testable import TrendingMovies

/**
    O objetivo dessa classe e testar as regras de negócio e seus respectivos comportamentos dentro do fluxo de `Login`,
    utiliizando uma abordagem chamada `BDD` Behaviour Driven Development,
    onde o próprio nome já diz testamos se o comportamento
    do nosso app está correto com base em uma sequencia de eventos.
    Resumindo "Como o nosso app deve se comportar caso o usuário faça tal coisa.."
 
    Isso não substitui o `XCUITest` que ainda pode ser usado em momentos específicos e de mais complexidad
    para ser feito, entretanto com `BDD` ganhamos muito mais performance nos testes de interface.
 */

class ListMoviesLoginTests: XCTestCase {

    /// `RN 1.` When user successfully login change session state to `hasSession`
    func test_userAuthentication_Success() {

        /// We should do the same with `RN 3.`
        let mockSession = SessionManagerStub(state: .notHaveSession)

        let user: UserDTO = createValidMockUserResponse()
            let repository: LoginRepository = LoginRepositoryStub(result: user)
            let coordinator = LoginCoordinatorDummy()
            let viewModel = LoginViewModel(coordinator: coordinator, repository: repository, session: mockSession)
        let sut = LoginViewController(viewModel: viewModel)

        sut.loadViewIfNeeded()

        let spy = ValueSessionSpy(mockSession.sessionState.eraseToAnyPublisher())

        // then
        XCTAssertEqual(spy.values, [.notHaveSession])

        // when
        sut.customView.authButton.sendActions(for: .touchUpInside)

        // then
        XCTAssertEqual(spy.values, [.notHaveSession, .hasSession])

    }

    /// `RN 3.` When user type wrong credential an alert shoud pop in
    func test_userAuthentication_Error() { }

}

private func createLoginMockSession(session: SessionManagerProtocol) -> LoginViewController {
    let user: UserDTO = createValidMockUserResponse()
    let repository: LoginRepository = LoginRepositoryStub(result: user)
    let coordinator = LoginCoordinatorDummy()
    let viewModel = LoginViewModel(coordinator: coordinator, repository: repository, session: session)
    viewModel.didUpdateDocumentTextField(document: "email@google.com")
    viewModel.didUpdatePasswordTextField(password: "123456")
    return LoginViewController(viewModel: viewModel)
}

private func createMockLoginViewControllerAuthError(session: SessionManagerProtocol) -> LoginViewController {
    let user: UserDTO = createInvalidMockUserResponse()
    let repository: LoginRepository = LoginRepositoryStub(result: user)
    let coordinator = LoginCoordinatorDummy()
    let viewModel = LoginViewModel(coordinator: coordinator, repository: repository, session: session)
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

    let repository: LoginRepository = LoginRepositoryStub(result: createValidMockUserResponse())

    let mockSession = SessionManagerStub(state: .notHaveSession)

    return LoginViewModel(coordinator: coordinator, repository: repository, session: mockSession)
}

// MARK: - Login Repository Layer

private class ValueSessionSpy {
    private(set) var values = [UserSessionState]()
    private var cancellable: AnyCancellable?

    init(_ publisher: AnyPublisher<UserSessionState, Error>) {
        cancellable = publisher.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
            self?.values.append(value)
        })
    }
}
