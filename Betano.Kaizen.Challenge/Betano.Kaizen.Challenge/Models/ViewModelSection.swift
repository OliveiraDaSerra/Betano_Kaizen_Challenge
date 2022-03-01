//
//  ViewModelSection.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation

typealias SectionReturnHandler = (String?, String?) -> Void

class ViewModelSection: SectionElementIdentity {
    var key: String?
    var titleData: HeaderFooterData?
    var expanded: Bool
    var fields: [FieldBase]?
    var handler: SectionReturnHandler?

    init(with key: String? = nil,
         titleData: HeaderFooterData?,
         isExpanded: Bool = false,
         fields: [FieldBase]? = nil) {
        self.key = key
        self.titleData = titleData
        self.expanded = isExpanded
        self.fields = fields
    }
}
