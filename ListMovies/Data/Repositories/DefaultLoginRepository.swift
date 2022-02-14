//
//  DefaultLoginRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class DefaultLoginRepository: LoginRepository {
    func auth(credentials: LoginModel, completion: @escaping (Result<UserApi, APIError>) -> Void) {
        let user = UserApi(name: "Raphael Oliveira", mail: "raphael@developer.com")
        completion(.success(user))
    }
}
