//
//  ContainerRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

enum ApplicationState {

    case logged(hasProfile: Bool)
    case notLogged
    case expired

    var identifier: String {
        switch self {
        case .logged:
            return "logged"
        case .notLogged:
            return "notLogged"
        case .expired:
            return "expired"
        }
    }
}

protocol ContainerRepository {
    var applicationState: CurrentValueSubject<ApplicationState, Error> { get }
}
