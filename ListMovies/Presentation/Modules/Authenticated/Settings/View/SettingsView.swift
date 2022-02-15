//
//  SettingsView.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/14/22.
//

import UIKit

class SettingsView: BaseView {

    // MARK: - UI Elements

    internal let logoutButton: UIButton = {
        return BaseButton(backgroundColor: UIColor.errorRed, title: Localized.Settings.LogOut)
    }()

    // MARK: - Lyfe Cicle

    init() {
        super.init(frame: CGRect.zero)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SettingsView {

    // MARK: - Layout

    func setupLayout() {

        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
