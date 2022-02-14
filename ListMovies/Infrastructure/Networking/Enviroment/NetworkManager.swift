//
//  NetworkManager.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

struct NetworkManager {
    // MARK: - Vars & Lets
    static let networkEnviroment: NetworkEnvironment = .production

    struct URLs {
        static var baseURL: URL {

            var base: String = ""

            switch networkEnviroment {
                case .dev:
                    base = "https://api.test.com/dev/"
                case .production:
                    base = "https://api.test.com/prod/"
                case .stage:
                    base = "https://api.test.com/staging/"
            }

            guard let url = URL(string: base) else {
                fatalError("Error to convert string url to URL")
            }
            return url
        }
    }

    struct Headers {
        static var contentTypeApplicationJSON = ["Content-Type": "application/json"]
    }
}
