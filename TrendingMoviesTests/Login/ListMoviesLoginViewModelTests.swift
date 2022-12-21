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
        let loginViewModel = createMockLoginViewModel()

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

/// Create a mock login view model to use in tests
private func createMockLoginViewModel() -> LoginViewModelProtocol {
    let repository: LoginRepository = LoginRepositoryStub(result: createValidMockUserResponse())
    let mockSession = SessionManagerStub(state: .notHaveSession)
    return LoginViewModel(coordinator: LoginCoordinatorDummy(), repository: repository, session: mockSession)
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
