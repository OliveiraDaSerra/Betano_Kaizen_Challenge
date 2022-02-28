//
//  ViewModelSection.swift
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

class ViewModelSection: ElementIdentity {
    var key: String?
    var title: String?
    var headerFooterData: HeaderFooterData?
    var expanded: Bool
    var fields: [FieldBase]?

    init(with key: String? = nil,
         title: String? = nil,
         headerFooterData: HeaderFooterData?,
         isExpanded: Bool = false,
         fields: [FieldBase]? = nil) {
        self.key = key
        self.title = title
        self.headerFooterData = headerFooterData
        self.expanded = isExpanded
        self.fields = fields
    }
}
