//
//  ViewStateSubject.swift
//  ListMovies
//
//  Created by Raphael Oliveira on 2/13/22.
//

import UIKit
import Combine

class ViewStateSubject: Subject {

    private let wrapped: CurrentValueSubject<Output, Failure> = .init(.normal)

    typealias Output = ViewState
    typealias Failure = Error

    func send(_ value: Output) {
        wrapped.send(value)
    }

    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }

    func send(subscription: Subscription) {
        wrapped.send(subscription: subscription)
    }

    func receive<Downstream: Subscriber>(subscriber: Downstream) where Failure == Downstream.Failure, Output == Downstream.Input {
        wrapped.subscribe(subscriber)
    }
}

extension ViewStateSubject {
    func onNormal() {
        wrapped.send(.normal)
    }

    func onLoading() {
        wrapped.send(.loadingNormal)
    }

    func onLoading(text: String) {
        wrapped.send(.loadingWith(text: text))
    }

    func onError(viewModel: PlaceholderViewModel) {
        wrapped.send(.failure(viewModel))
    }
}
