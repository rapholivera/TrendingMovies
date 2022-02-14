//
//  SettingsFactory.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class SettingsFactory {
    // MARK: - Life Cycle
    class func build(coordinator: SettingsCoordinatorProtocol) -> SettingsViewController {
        let viewModel = DefaultSettingsViewModel(coordinator: coordinator)
        return SettingsViewController(viewModel: viewModel)
    }
}
