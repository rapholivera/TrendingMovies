//
//  LoginRepositoryStub.swift
//  TrendingMoviesTests
//
//  Created by Raphael Oliveira on 20/12/22.
//

@testable import TrendingMovies

class LoginRepositoryStub: LoginRepository {

    private let result: Result<UserDTO, APIError>

    init(result: UserDTO) {
        self.result = .success(result)
    }
    init(result: APIError) {
        self.result = .failure(result)
    }

    func auth(credentials: LoginModel, completion: @escaping (Result<UserDTO, APIError>) -> Void) {
        completion(result)
    }
}
