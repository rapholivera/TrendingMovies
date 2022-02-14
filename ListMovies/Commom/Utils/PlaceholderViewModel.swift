//
//  PlaceholderViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

enum PlaceholderType {
    case loading
    case error
}

struct PlaceholderViewModel {

    var text: String?
    var action: (() -> Void)?
    var cancelAction: (() -> Void)?

    init(text: String? = nil, action: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        self.text = text
        self.action = action
        self.cancelAction = cancelAction
    }
}
