//
//  MockSessionManager.swift
//  TrendingMoviesTests
//
//  Created by Raphael Oliveira on 12/04/22.
//

import UIKit
import Combine

@testable import TrendingMovies

final class MockSessionManager {

    private let mockStateSubject: CurrentValueSubject<UserSessionState, Error>
    private var cachedSession: UserSessionDB? {
        didSet {
            if let _ = cachedSession {
                mockStateSubject.send(.hasSession)
            }
        }
    }

    init(state: UserSessionState) {
        self.mockStateSubject = .init(state)
    }
}

extension MockSessionManager: SessionManagerProtocol {
    var sessionState: CurrentValueSubject<UserSessionState, Error> {
        return mockStateSubject
    }

    func logout() {}

    func expireSession() {}

    func retrieveUserSession() -> UserSessionDB? {
        return nil
    }

    func createUserSession(accessToken: String?, currentUser: UserDB?) throws {
        if let accessToken = accessToken, let currentUser = currentUser {
            cachedSession = UserSessionDB(accessToken: accessToken, currentUser: currentUser)
        } else {
            throw AuthManagerError.errorToCreateSession
        }
    }

    func updateSession(accessToken: String?, currentUser: UserDB?) throws {

    }
}
