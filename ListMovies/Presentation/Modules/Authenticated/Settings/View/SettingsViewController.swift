//
//  SettingsViewController.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

protocol SettingsViewModel {

}

class SettingsViewController: BaseViewController<SettingsView> {

    // MARK: - Properties

    private var viewModel: SettingsViewModel {
        return baseViewModel as! SettingsViewModel
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings" // R.string.title.settings()
        customView.logoutButton.addTarget(self, action: #selector(clickLogout), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func clickLogout() {

        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Logout"/*R.string.base.defaultLogout()*/, style: .destructive, handler: { (_) in
            // Zapdesk.disconnect()
            SessionManager.shared.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel"/*R.string.base.defaultCancel()*/, style: .default, handler: { (_) in }))

        present(alert, animated: true, completion: nil)
    }
}
