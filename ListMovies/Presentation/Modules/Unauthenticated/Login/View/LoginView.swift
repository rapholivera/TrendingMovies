//
//  LoginView.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

class LoginView: BaseView {

    // MARK: - UI Elements

    private let headerTitle: UILabel = {
        let header = BaseTitleLabel(textAlignment: .center)
        header.text = "MVVM Project"
        header.font = UIFont(name: "HelveticaNeue-Bold", size: 21.0)
        return header
    }()

    internal lazy var documentTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.applyAppearence(type: .number, placeholder: "CPF")
        textField.returnKeyType = .default
        textField.keyboardPlaceholder = "Digite seu CPF ou CNPJ"
        return textField
    }()

    internal let passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.applyAppearence(type: .password, placeholder: "Password")
        textField.keyboardPlaceholder = "Digite sua senha"
        return textField
    }()

    internal let authButton: AppButton = {
        return AppButton(backgroundColor: .clear, title: "Sign In")
    }()

    internal let registerButton: UIButton = {
        return AppButton(backgroundColor: .backgroundSecundaryColor, title: "Create account")
    }()

    // MARK: - Lyfe Cicle

    init() {
        super.init(frame: CGRect.zero)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        authButton.applyGradient(colors: [UIColor.buttonGradientPrimaryColor, UIColor.buttonGradientSecundaryColor])
    }
}

extension LoginView {

    // MARK: - Layout

    func setupLayout() {

        addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        addSubview(authButton)
        authButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authButton.bottomAnchor.constraint(equalTo: centerYAnchor),
            authButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -16),
            authButton.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            authButton.trailingAnchor.constraint(equalTo: registerButton.trailingAnchor),
            authButton.heightAnchor.constraint(equalTo: registerButton.heightAnchor)
        ])

        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(equalTo: authButton.topAnchor, constant: -32),
            passwordTextField.leadingAnchor.constraint(equalTo: authButton.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: authButton.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        ])

        addSubview(documentTextField)
        documentTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            documentTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -16),
            documentTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            documentTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            documentTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])

        addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.bottomAnchor.constraint(equalTo: documentTextField.topAnchor, constant: -32),
            headerTitle.leadingAnchor.constraint(equalTo: documentTextField.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: documentTextField.trailingAnchor)
        ])
    }
}
