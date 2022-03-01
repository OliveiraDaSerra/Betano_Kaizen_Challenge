//
//  FieldBase.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

class FieldBase: ElementIdentity {
    var key: String?
    var title: String?
    var favourite: Bool
    var startTime: Double?

    init(with key: String? = nil,
         title: String? = nil,
         favourite: Bool = false,
         startTime: Double? = nil) {
        self.key = key
        self.title = title
        self.favourite = favourite
        self.startTime = startTime
    }
}
