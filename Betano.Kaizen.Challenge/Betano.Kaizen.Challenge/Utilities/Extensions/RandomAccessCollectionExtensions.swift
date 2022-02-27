//
//  RandomAccessCollectionExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation

extension RandomAccessCollection {
    subscript(index: Index) -> Element? {
        self.indices.contains(index) ? (self[index] as Element) : nil
    }
}
