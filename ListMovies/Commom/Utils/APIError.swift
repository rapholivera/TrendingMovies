//
//  APIError.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

enum APIError: Error {
    case noInternectConnection
    case noUserSessionAvailable
    case badResponse
    case badRequest
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternectConnection:
            return NSLocalizedString("", comment: "")
        case .noUserSessionAvailable:
            return NSLocalizedString("", comment: "")
        case .badResponse:
            return NSLocalizedString("", comment: "")
        case .badRequest:
            return NSLocalizedString("", comment: "")
        }
    }
}
