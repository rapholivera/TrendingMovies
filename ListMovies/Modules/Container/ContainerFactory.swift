//
//  ContainerFactory.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class ContainerFactory: UIView {
    // MARK: - Life Cycle
    class func build(coordinator: ContainerCoordinatorProtocol) -> ContainerViewController {
        let repository = DefaultContainerRepository()
        let viewModel = ContainerViewModel(coordinator: coordinator, repository: repository)
        return ContainerViewController(viewModel: viewModel)
    }

}
