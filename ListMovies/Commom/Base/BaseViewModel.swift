//
//  BaseViewModel.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

protocol BaseViewModelProtocol {

    var viewState: ViewStateSubject { get }
    var alert: PassthroughSubject<String, Error> { get }
}

class BaseViewModel: NSObject {

    internal let newViewStateSubject = ViewStateSubject()
    internal let alertSubject: PassthroughSubject<String, Error> = .init()

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseViewModel: BaseViewModelProtocol {

    var viewState: ViewStateSubject {
        return newViewStateSubject
    }

    var alert: PassthroughSubject<String, Error> {
        return alertSubject
    }
}
