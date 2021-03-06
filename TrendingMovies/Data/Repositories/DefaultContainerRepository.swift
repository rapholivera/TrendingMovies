//
//  DefaultContainerRepository.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

class DefaultContainerRepository: NSObject {

    private let state: CurrentValueSubject<ApplicationState, Error> = .init(.expired)
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init Methods
    override init() {
        super.init()
        self.bind()
    }

    private func bind() {
        SessionManager.shared.sessionState.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (sessionState) in

            guard let self = self else { return }

            var state: ApplicationState = .expired

            switch sessionState {
            case .hasSession:
                state = .logged(hasProfile: true)

            case .notHaveSession:
                state = .notLogged

            case .sessionExpired:
                state = .expired
            }

            self.state.send(state)

        }).store(in: &subscriptions)
    }
}

extension DefaultContainerRepository: ContainerRepository {
    var applicationState: CurrentValueSubject<ApplicationState, Error> {
        return state
    }
}
