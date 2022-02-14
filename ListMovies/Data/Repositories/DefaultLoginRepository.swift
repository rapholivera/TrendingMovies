//
//  DefaultLoginRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class DefaultLoginRepository: LoginRepository {
    func auth(credentials: LoginModel, completion: @escaping (Result<UserDTO, APIError>) -> Void) {
        let randomAccessToken: String = UUID().uuidString
        let user = UserDTO(name: "Raphael Oliveira", code: randomAccessToken, mail: "raphael@developer.com")
        completion(.success(user))
    }
}
