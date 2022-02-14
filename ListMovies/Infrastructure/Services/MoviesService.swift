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
            return "trending/movie/week"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        switch self {
        case .getTrendingMovies:
            return .requestParameters(urlEncoding: .urlEncoding, urlParameters: ["api_key": "41402daeee2f923b29854d023fe22e1a"])
        }
    }
    var headers: [String: String]? {
        return NetworkManager.Headers.contentTypeApplicationJSON
    }
}
