//
//  Localized+Settings.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import Foundation

extension Localized {

    enum Settings {
        /// O `Settings.strings` should have all strings in settings module
        static private var table: String { "Settings" }
        /// `Log Out` action
        static var LogOut: String {
            return NSLocalizedString("logout", tableName: table, bundle: bundle, comment: "")
        }
        /// `Log Out` action
        static var SettingsTitle: String {
            return NSLocalizedString("settings", tableName: table, bundle: bundle, comment: "")
        }
        /// `Log Out` confirmation message
        static var LogOutConfirmation: String {
            return NSLocalizedString("logoutConfirmationMessage", tableName: table, bundle: bundle, comment: "")
        }
    }
}
