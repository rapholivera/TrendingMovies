//
//  ListMoviesLoginViewModelTests.swift
//  TrendingMoviesTests
//
//  Created by Raphael Oliveira on 20/12/22.
//

import XCTest
import Combine

@testable import TrendingMovies

final class ListMoviesLoginViewModelTests: XCTestCase {

    /// `RN 1.` Signing button should be enabled only if booth `Document` and `Password` fields are filled
    func test_should_validate_user_input_when_form_fields_changes() {

        // given
        let loginViewModel = createMockNewUserLoginViewModel()

        let spy = ValueSpy(loginViewModel.isInputValid)

        // then
        XCTAssertEqual(spy.values, [false])

        // when
        loginViewModel.didUpdateDocumentTextField(document: "email@google.com")

        // then
        XCTAssertEqual(spy.values, [false, false])

        // when
        loginViewModel.didUpdatePasswordTextField(password: "password123")

        // then
        XCTAssertEqual(spy.values, [false, false, true])
    }

}

/// Cria um `ViewModel` com suas dependências simulando um usuário novo
private func createMockNewUserLoginViewModel() -> LoginViewModelProtocol {
    let user: UserDTO = createValidMockUserResponse()
    let repository: LoginRepository = LoginRepositoryStub(result: user)
    let coordinator = LoginCoordinatorDummy()
    return LoginViewModel(coordinator: coordinator, repository: repository,
                          session: SessionManagerStub(state: .notHaveSession))
}

private func createValidMockUserResponse() -> UserDTO {
    let randomAccessToken: String = UUID().uuidString
    return UserDTO(name: "User", code: randomAccessToken, mail: "movies@movies.com")
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
