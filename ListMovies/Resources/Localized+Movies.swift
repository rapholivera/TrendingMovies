//
//  Localized+Movies.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import Foundation

extension Localized {

    enum Movies {
        /// O `Settings.strings` should have all strings in settings module
        static private var table: String { "Movies" }
        /// Trending movies title
        static var Trending: String {
            return NSLocalizedString("trendingMovies", tableName: table, bundle: bundle, comment: "")
        }
        /// Loading messages when request trending movies
        static var LoadingMovies: String {
            return NSLocalizedString("loadingMovies", tableName: table, bundle: bundle, comment: "")
        }
    }
}
