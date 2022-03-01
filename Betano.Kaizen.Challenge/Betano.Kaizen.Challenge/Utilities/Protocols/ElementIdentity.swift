//
//  ElementIdentity.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

struct HeaderFooterDataContent {
    var title: String?
}

struct HeaderFooterData {
    var headerData: HeaderFooterDataContent?
    var footerData: HeaderFooterDataContent?
}

protocol ElementIdentity {
    var key: String? { get set }
    var title: String? { get set }
}

protocol SectionElementIdentity {
    var key: String? { get set }
    var titleData: HeaderFooterData? { get set }
}
