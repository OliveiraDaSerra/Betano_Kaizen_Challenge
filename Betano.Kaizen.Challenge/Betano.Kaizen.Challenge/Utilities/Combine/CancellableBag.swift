//
//  CancellableBag.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Combine

class CancellableBag {
    var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}
