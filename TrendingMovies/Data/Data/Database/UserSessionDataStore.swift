//
//  UserSessionDataStore.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

protocol UserSessionDataStoreProtocol {
    func creatUserSession(accessToken: String, currentUser: UserDB) -> UserSessionDB
    func retrieveUserSession() -> UserSessionDB?
    func updateSession(accessToken: String?, currentUser: UserDB?) throws -> UserSessionDB
    func deleteUserSession()
}

class UserSessionDataStore: NSObject {

    private let currentSessionKey = "current_session_key"

    private func saveCurrentSessionWith(userSession: UserSessionDB?) {
        KeyedArchiverManager.saveObjectWith(key: currentSessionKey, object: userSession)
    }
}

extension UserSessionDataStore: UserSessionDataStoreProtocol {

    func creatUserSession(accessToken: String, currentUser: UserDB) -> UserSessionDB {
        let newUserSession = UserSessionDB(accessToken: accessToken, currentUser: currentUser)
        saveCurrentSessionWith(userSession: newUserSession)
        return newUserSession
    }

    func retrieveUserSession() -> UserSessionDB? {
        return KeyedArchiverManager.retrieveObjectWith(key: currentSessionKey, type: UserSessionDB.self)
    }

    func updateSession(accessToken: String?, currentUser: UserDB?) throws -> UserSessionDB {
        guard let userSession = retrieveUserSession() else {
            throw AuthManagerError.noSession
        }

        let updatedUserSession = UserSessionDB(accessToken: accessToken ?? userSession.accessToken, currentUser: currentUser ?? userSession.currentUser)
        saveCurrentSessionWith(userSession: updatedUserSession)

        return updatedUserSession
    }

    func deleteUserSession() {
        saveCurrentSessionWith(userSession: nil)
    }
}
