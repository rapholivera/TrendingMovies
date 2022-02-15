//
//  TabBarViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol HomeTabBarViewModel: BaseViewModelProtocol {

}

class HomeTabBarViewController: UITabBarController {

    var viewModel: HomeTabBarViewModel!

    init(viewModel: HomeTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        applyAppearence()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func applyAppearence() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .backgroundSecundaryColor
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
}
