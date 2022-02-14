//
//  DefaultLoginRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class DefaultLoginRepository: LoginRepository {
    func auth(credentials: LoginModel, completion: @escaping (Result<UserApi, APIError>) -> Void) {
        let randomAccessToken: String = UUID().uuidString
        let user = UserApi(name: "Raphael Oliveira", code: randomAccessToken, mail: "raphael@developer.com")
        completion(.success(user))
    }
}
