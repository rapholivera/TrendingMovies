//
//  SettingsViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol SettingsCoordinatorProtocol {

}

class DefaultSettingsViewModel: BaseViewModel {
    private let coordinator: SettingsCoordinatorProtocol

    // MARK: - Init Methods
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init()
    }
}
