//
//  ContainerViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

enum ContentPageType {
    case unauthenticated
    case buildProfile
    case home
}

protocol ContainerCoordinatorProtocol {
    func updateCurrentPage(_ page: ContentPageType)
}

class ContainerViewModel: BaseViewModel {

    private let containerRepository: ContainerRepository
    private let coordinator: ContainerCoordinatorProtocol

    init(coordinator: ContainerCoordinatorProtocol, repository: ContainerRepository) {
        self.containerRepository = repository
        self.coordinator = coordinator
        super.init()
    }
}

extension ContainerViewModel: ContainerViewModelProtocol {
    var applicationStateDidChange: CurrentValueSubject<ApplicationState, Error> {
        return containerRepository.applicationState
    }
    func updateCurrentPage(page: ContentPageType) {
        coordinator.updateCurrentPage(page)
    }
}
