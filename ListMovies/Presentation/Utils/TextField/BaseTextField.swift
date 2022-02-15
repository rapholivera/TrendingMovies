//
//  BaseTextField.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

class BaseTextField: UIView {

    private var error: String?
    private var canShowError: Bool = false {
        didSet {
            showError()
        }
    }

    internal lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    internal lazy var textField: TextField = {
        let textField = TextField()
        textField.delegate = self
        textField.textColor = .white
        textField.tintColor = .white
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 0.0
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.placeholder = nil
        return textField
    }()

    init() {
        super.init(frame: .zero)
        defaultInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }

    private func defaultInit() {
        addTextField()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapRecognizer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = frame.size.height / 4
        layer.masksToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = .backgroundSecundaryColor// UIColor.white.withAlphaComponent(0.10)
    }

    private func addTextField() {
//        self.addSubview(placeholderLabel)
//        self.addSubview(textField)
//        constrain(self, placeholderLabel, textField) { (container, placeholder, field) in
//            placeholder.top == container.top
//            placeholder.left == container.left + 10
//            placeholder.right == container.right
//
//            field.height == 48
//            field.top == placeholder.bottom + 10
//            field.left == container.left
//            field.right == container.right
//            field.bottom == container.bottom
//        }

//        addSubview(placeholderLabel)
//        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
//            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor)/*,
//            placeholderLabel.heightAnchor.constraint(equalToConstant: 55)*/
//        ])

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor/*, constant: 10*/),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)/*,
            textField.heightAnchor.constraint(equalToConstant: 50)*/
        ])
    }

    private func showError() {
        if let error = error, canShowError {
            self.textField.layer.borderColor = UIColor.errorRed.cgColor
            self.placeholderLabel.text = error
            self.placeholderLabel.textColor = UIColor.errorRed
            self.textField.layer.borderColor = UIColor.errorRed.cgColor
        } else {
            self.textField.layer.borderColor = UIColor.clear.cgColor
            self.placeholderLabel.text = placeholder
            self.placeholderLabel.textColor = .lightGray
            self.textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension BaseTextField {

    @objc func handleTap() {
        _ = textField.becomeFirstResponder()
    }

    @objc override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
}

extension BaseTextField {

    var textColor: UIColor? {
        get { return textField.textColor }
        set { textField.textColor = newValue }
    }

    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }

    var placeholder: String? {
        get { return textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var returnKeyType: UIReturnKeyType? {
        get { return textField.returnKeyType }
        set { textField.returnKeyType = newValue ?? .default }
    }

    var textPublisher: AnyPublisher<String, Never> {
        return textField.textPublisher
    }

    var keyboardPlaceholder: String? {
        get { return textField.toolbarPlaceholder }
        set { textField.toolbarPlaceholder = newValue }
    }

    var autocorrectionType: UITextAutocorrectionType {
        get { return textField.autocorrectionType }
        set { textField.autocorrectionType = newValue }
    }

    func setError(_ error: String?) {
        self.error = error
        showError()
    }
}

extension BaseTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        canShowError = false
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        canShowError = true
        return true
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

// extension TextField {
//    open override var text: String?  {
//        didSet {
//            if let mascara = self.maskText, let tex = text {
//                let formatter = TCTextMask()
//                formatter.formattingPattern = mascara
//                super.text = formatter.formatString(string: tex)
//            } else {
//                super.text = text
//            }
//        }
//    }
// }
