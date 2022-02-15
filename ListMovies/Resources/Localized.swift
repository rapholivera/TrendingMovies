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
        /// Message showing witch type of document should be filled
        static var TypeCPFMessage: String {
            return NSLocalizedString("typeCPFMessage", tableName: table, bundle: bundle, comment: "")
        }
        /// Message showing witch field will receive user password
        static var TypePasswordMessage: String {
            return NSLocalizedString("typePasswordMessage", tableName: table, bundle: bundle, comment: "")
        }
        static var Password: String {
            return NSLocalizedString("password", tableName: table, bundle: bundle, comment: "")
        }
        static var Signin: String {
            return NSLocalizedString("signin", tableName: table, bundle: bundle, comment: "")
        }
        static var CreateAccount: String {
            return NSLocalizedString("createAccount", tableName: table, bundle: bundle, comment: "")
        }
        static var Ok: String {
            return NSLocalizedString("ok", tableName: table, bundle: bundle, comment: "")
        }
        static var TryAgain: String {
            return NSLocalizedString("tryAgain", tableName: table, bundle: bundle, comment: "")
        }
    }
}
