//
//  KeyboardHandler.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import IQKeyboardManagerSwift

protocol KeyboardHandlerProtocol {
    func setup()
}

class KeyboardHandler: KeyboardHandlerProtocol {
    // MARK: - Properties
    static let shared: KeyboardHandlerProtocol = KeyboardHandler()

    func setup() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableDebugging = false
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemImage = UIImage(named: "arrow-down-close")
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(BaseView.self)
    }
}
