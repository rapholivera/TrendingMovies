//
//  Localized.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import Foundation

final class Localized {
    static var bundle: Bundle {
        Bundle(for: Localized.self)
    }
}

extension Localized {

    enum Default {
        /// The `Default.strings` should have all base strings in app
        static private var table: String { "Default" }
        /// `Cancel` action used in alerts and confirmations
        static var Cancel: String {
            return NSLocalizedString("cancel", tableName: table, bundle: bundle, comment: "")
        }
    }
}
