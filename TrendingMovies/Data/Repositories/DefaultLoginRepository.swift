//
//  DefaultLoginRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class DefaultLoginRepository: LoginRepository {
    func auth(credentials: LoginModel, completion: @escaping (Result<UserDTO, APIError>) -> Void) {
        // TODO: make a real auth request
        if credentials.password == "123456" {
            let randomAccessToken: String = UUID().uuidString
            let user = UserDTO(name: "Movies USer", code: randomAccessToken, mail: "movies@developer.com")
            completion(.success(user))
        } else {
            completion(.failure(.badCredentials))
        }
    }
}
