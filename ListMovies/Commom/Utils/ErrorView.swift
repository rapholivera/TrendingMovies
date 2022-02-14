//
//  ErrorView.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class ErrorView: UIView {

    private var actionBlock: (() -> Void)?
    private var cancelBlock: (() -> Void)?

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 17)
        return textLabel
    }()

    private lazy var errorImage: UIImageView = {
        let errImageView = UIImageView()
        errImageView.image = UIImage(systemName: "wifi.slash")
        errImageView.contentMode = .scaleAspectFit
        return errImageView
    }()

    private lazy var tryAgainButton: UIButton = {
        return AppButton(backgroundColor: .lightGray, title: "Tentar novamente")
    }()

    private lazy var cancelButton: UIButton = {
        return AppButton(backgroundColor: .lightGray, title: "Cancel")
    }()

    private lazy var okButton: UIButton = {
        return AppButton(backgroundColor: .lightGray, title: "Ok")
    }()

    init() {
        super.init(frame: UIScreen.main.bounds)
        createScreen()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func createScreen() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.35)

        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])

        addSubview(errorImage)
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            errorImage.heightAnchor.constraint(equalTo: errorImage.widthAnchor),
            errorImage.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16)
        ])

    }

    private func addTryAgainButton() {

        addSubview(tryAgainButton)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryAgainButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 32),
            tryAgainButton.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            tryAgainButton.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: tryAgainButton.bottomAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalTo: tryAgainButton.heightAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: tryAgainButton.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: tryAgainButton.trailingAnchor)
        ])
    }

    private func addOkButton() {

        addSubview(okButton)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            okButton.heightAnchor.constraint(equalTo: textLabel.heightAnchor),
            okButton.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor)
        ])
    }

    private func dismiss() {
        UIView.animate(withDuration: 0.5, animations: { self.alpha = 0 },
                       completion: { (_) in self.removeFromSuperview() })
    }
}

extension ErrorView {

    func presentOn(parentView: UIView, with viewModel: PlaceholderViewModel) {
        textLabel.text = viewModel.text
        actionBlock = viewModel.action
        cancelBlock = viewModel.cancelAction

        if viewModel.action != nil {
            addTryAgainButton()
        } else {
            addOkButton()
        }

        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])

        self.alpha = 0
        UIView.animate(withDuration: 0.5, animations: { self.alpha = 1 })
    }
}
