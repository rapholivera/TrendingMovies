//
//  SessionManager.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

enum UserSessionState {
    case hasSession(session: UserSessionDB)
    case notHaveSession
    case sessionExpired
}

enum AuthManagerError: Swift.Error {
    case noSession
    case errorToCreateSession
}

protocol SessionManagerProtocol {
    var sessionState: CurrentValueSubject<UserSessionState, Error> { get }

    func logout()
    func expireSession()
    func retrieveUserSession() -> UserSessionDB?
    func createUserSession(accessToken: String?, currentUser: UserDB?) throws
    func updateSession(accessToken: String?, currentUser: UserDB?) throws
}

class SessionManager {

    static let shared: SessionManagerProtocol = SessionManager(sessionDataStore: UserSessionDataStore())

    private let sessionDataStore: UserSessionDataStoreProtocol

    private var cachedSession: UserSessionDB? {
        didSet {
            if let cachedSession = cachedSession {
                stateSubject.send(.hasSession(session: cachedSession))
            }
        }
    }

    private lazy var stateSubject: CurrentValueSubject<UserSessionState, Error> = {
        if let sessionDB = self.retrieveUserSession() {
            return CurrentValueSubject<UserSessionState, Error>(.hasSession(session: sessionDB))
        } else {
            return CurrentValueSubject<UserSessionState, Error>(.notHaveSession)
        }
    }()

    private init(sessionDataStore: UserSessionDataStoreProtocol) {
        self.sessionDataStore = sessionDataStore
    }

    private func deleteUserSession() {
        sessionDataStore.deleteUserSession()
        cachedSession = nil
    }
}

extension SessionManager: SessionManagerProtocol {

    var sessionState: CurrentValueSubject<UserSessionState, Error> {
        return stateSubject
    }

    func logout() {
        deleteUserSession()
        stateSubject.send(.notHaveSession)
    }

    func expireSession() {
        deleteUserSession()
        stateSubject.send(.sessionExpired)
    }

    func retrieveUserSession() -> UserSessionDB? {
        if let cachedSession = cachedSession {
            return cachedSession
        }

        return sessionDataStore.retrieveUserSession()
    }

    func createUserSession(accessToken: String?, currentUser: UserDB?) throws {
        if let accessToken = accessToken, let currentUser = currentUser {
            cachedSession = sessionDataStore.creatUserSession(accessToken: accessToken, currentUser: currentUser)
        } else {
            throw AuthManagerError.errorToCreateSession
        }
    }

    func updateSession(accessToken: String?, currentUser: UserDB?) throws {
        cachedSession = try? sessionDataStore.updateSession(accessToken: accessToken, currentUser: currentUser)
    }
}
