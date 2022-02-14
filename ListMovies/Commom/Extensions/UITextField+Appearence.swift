//
//  UITextField+Appearence.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

enum BaseTextFieldType {
    case email
    case password
    case name
    case text
    case decimal
    case number
    case cpf
    case `default`
}

extension BaseTextField {

    func applyAppearence(type: BaseTextFieldType, placeholder: String, enabled: Bool = true) {
        self.placeholder = placeholder

        switch type {
        case .email:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .emailAddress
            self.textField.autocorrectionType = .no

        case .password:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .default
            self.textField.autocorrectionType = .no
            self.textField.isSecureTextEntry = true

        case .name:
            self.textField.autocapitalizationType = .words
            self.textField.keyboardType = .default
            self.textField.autocorrectionType = .no

        case .text:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .default
            self.textField.autocorrectionType = .yes

        case .decimal:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .decimalPad
            self.textField.autocorrectionType = .no

        case .number:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .numberPad
            self.textField.autocorrectionType = .no

        case .cpf:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .numberPad
            self.textField.autocorrectionType = .no

        default:
            self.textField.autocapitalizationType = .none
            self.textField.keyboardType = .default
            self.textField.autocorrectionType = .no
        }

        self.textField.isEnabled = enabled
        self.textField.backgroundColor = enabled ? self.textField.backgroundColor : .clear
        self.textField.layer.borderWidth = CGFloat(NSNumber(value: enabled).floatValue)
        self.textField.textColor = enabled ? self.textField.textColor : .lightGray
    }
}
