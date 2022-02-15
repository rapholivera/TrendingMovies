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
        navigationItem.title = Localized.Settings.SettingsTitle
        customView.logoutButton.addTarget(self, action: #selector(clickLogout), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func clickLogout() {

        let alert = UIAlertController(title: nil, message: Localized.Settings.LogOutConfirmation, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Localized.Settings.LogOut, style: .destructive, handler: { (_) in
            // Zapdesk.disconnect()
            SessionManager.shared.logout()
        }))
        alert.addAction(UIAlertAction(title: Localized.Default.Cancel, style: .default, handler: { (_) in }))

        present(alert, animated: true, completion: nil)
    }
}
