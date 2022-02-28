//
//  ViewModel.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input, disposeBag: CancellableBag) -> Output
}
