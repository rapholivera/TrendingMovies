//
//  ViewState.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit

enum ViewState {
    case normal
    case loadingNormal
    case loadingWith(text: String)
    case failure(PlaceholderViewModel)
}
