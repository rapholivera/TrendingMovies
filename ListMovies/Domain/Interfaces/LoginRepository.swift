//
//  LoginRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol LoginRepository {
    func auth(credentials: LoginModel, completion: @escaping (Result<UserDTO, APIError>) -> Void)
}
