//
//  CombineExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import Combine

// MARK: - Publisher

extension Publisher {
    func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - AnyCancellable

extension AnyCancellable {
    func store(in bag: CancellableBag) {
        bag.subscriptions.insert(self)
    }
}

// MARK: - PassthroughtSubject

extension PassthroughSubject where Output == Void, Failure: Error {
    func trigger() {
        self.send()
    }
}
