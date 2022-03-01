//
//  CommonExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

typealias MethodHandler = () -> Void

func executeInMainThread(_ execution: @escaping MethodHandler, after: Double = 0.0) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        execution()
    }
}

func executeInBackgroundThread(_ execution: @escaping MethodHandler, after: Double = 0.0) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + after) {
        execution()
    }
}

// MARK: -

func configureElement<T>(_ object: T, using closure: (inout T) -> Void) -> T {
    var object = object
    closure(&object)
    return object
}
