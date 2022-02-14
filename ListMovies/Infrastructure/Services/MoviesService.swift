//
//  MoviesService.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

enum MoviesService {
    case getTrendingMovies
}

extension MoviesService: EndpointTargetType {

    var baseURL: URL {
        return NetworkManager.URLs.baseURL
    }
    var path: String {
        switch self {
        case .getTrendingMovies:
            return "api/agora/getInvestorProfile"
        }
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var task: HTTPTask {
        switch self {
        case .getTrendingMovies:
            return .requestParameters(bodyParameters: [:], bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
    var headers: [String: String]? {
        return NetworkManager.Headers.contentTypeApplicationJSON
    }
}
