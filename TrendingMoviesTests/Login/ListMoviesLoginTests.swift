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

    /// `RN 1.` Se o usuário se autenticar corretamente o app deve mostrar a tela de filmes em destaque
    func test_should_show_trending_movies_when_user_succesfully_authenticated() {

        /// Simulamos um `ViewModel` preparado para testar um usuário novo
        let mockViewModel = createMockNewUserLoginViewModel()

        let sut = LoginViewController(viewModel: mockViewModel)

        sut.loadViewIfNeeded()

        // TODO: - Criar teste de validação de login

    }

    /// `RN 3.` When user type wrong credential an alert shoud pop in
    func test_userAuthentication_Error() { }

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
